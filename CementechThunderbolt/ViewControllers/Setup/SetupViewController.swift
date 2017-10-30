//
//  SetupViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 30/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import CoreBluetooth
import LayerUIExtention
class SetupViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var deviceTable: UITableView!
    @IBOutlet weak var scanActivityIndecator: UIActivityIndicatorView!
    @IBOutlet weak var selectedDeviceName: UILabel!
    @IBOutlet weak var selectedDeviceUUID: UILabel!    
    @IBOutlet weak var connectionIndicator: CustomUIView!
    @IBOutlet weak var btnConnect: UIBarButtonItem!
    var centralManager:CBCentralManager?
    var discoveredPeripheral:CBPeripheral?
    var data:String?
    var devices:[CBPeripheral] = []
    var isConnected:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        self.scanActivityIndecator.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state.rawValue == CBCentralManagerState.poweredOn.rawValue {
            print("Pwered on")
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
            self.scanActivityIndecator.isHidden = false
            self.scanActivityIndecator.startAnimating()
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        devices.append(peripheral)
        deviceTable.reloadData()
    }
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell: DeviceTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? DeviceTableViewCell
        if cell == nil {
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DeviceTableViewCell
        }
        if self.devices[indexPath.row].name != nil {
            cell.deviceName.text = self.devices[indexPath.row].name
        } else {
            cell.deviceName.text = "Unknown"
        }
        cell.deviceUUID.text = String(describing: self.devices[indexPath.row].identifier)
        return cell
    }
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDeviceName.text = devices[indexPath.row].name
        selectedDeviceUUID.text = String(describing: devices[indexPath.row].identifier)
        self.discoveredPeripheral = devices[indexPath.row]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func startScan(_ sender: Any) {
        self.centralManagerDidUpdateState(self.centralManager!)
        self.scanActivityIndecator.isHidden = false
        self.scanActivityIndecator.startAnimating()
    }
    @IBAction func actionConnectDisconnect(_ sender: Any) {
        if isConnected {
            self.cleanUp()
            btnConnect.title = "Connect"
            self.isConnected = false
            deviceTable.isUserInteractionEnabled = true
            self.connectionIndicator.backgroundColor = UIColor.red
        } else {
            self.centralManager?.connect(self.discoveredPeripheral!, options: nil)
        }
    }
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        self.connectionIndicator.backgroundColor = UIColor.red
        print("connection failed")
        self.cleanUp()
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Stop scan")
        self.centralManager?.stopScan()
        self.scanActivityIndecator.stopAnimating()
        self.scanActivityIndecator.isHidden  = true
        self.connectionIndicator.backgroundColor = UIColor.green
        self.isConnected = true
        btnConnect.title = "Disconnect"
        deviceTable.isUserInteractionEnabled = false
        peripheral.delegate = self;
        peripheral.discoverServices([CBUUID(string: "713D0000-503E-4C75-BA94-3148F18D941E")])
        
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Services")
        print(peripheral.services)
        if(error == nil){
            for service in peripheral.services! {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        } else {
            print("error")
            self.cleanUp()
            return
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("characteristics")
        for characteristic in service.characteristics! {
            self.discoveredPeripheral?.setNotifyValue(true, for: characteristic)
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print(String(data: characteristic.value!, encoding: String.Encoding.utf8))
    }
    func cleanUp(){
        if self.discoveredPeripheral?.services != nil {
            for service in (self.discoveredPeripheral?.services)! {
                if service.characteristics != nil {
                    for characteristic in service.characteristics! {
                        self.discoveredPeripheral?.setNotifyValue(false, for: characteristic)
                    }
                }
            }
        }
    }
}
