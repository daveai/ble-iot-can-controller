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
    @IBOutlet weak var tfReceivedChars: UITextView!
    @IBOutlet weak var btnConnect: UIBarButtonItem!
    @IBOutlet weak var tfSendContent: UITextField!
    @IBOutlet weak var testConnectionView: UIView!
    var centralManager:CBCentralManager?
    var discoveredPeripheral:CBPeripheral?
    var data:String?
    var devices:[CBPeripheral] = []
    var isConnected:Bool = false
    let serviceUUID = "713D0000-503E-4C75-BA94-3148F18D941E"
    let rxCharUUID = "713D0003-503E-4C75-BA94-3148F18D941E"
    let txCharUUID = "713d0002-503e-4c75-ba94-3148f18d941e"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        self.scanActivityIndecator.isHidden = true
        self.connectionIndicator.isHidden = true
        testConnectionView.isHidden = true
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
        self.connectionIndicator.isHidden = false
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func startScan(_ sender: Any) {
        devices.removeAll()
        deviceTable.reloadData()
        self.centralManagerDidUpdateState(self.centralManager!)
        self.scanActivityIndecator.isHidden = false
        self.scanActivityIndecator.startAnimating()
    }
    @IBAction func actionConnectDisconnect(_ sender: Any) {
        if isConnected {
            self.centralManager?.cancelPeripheralConnection(self.discoveredPeripheral!)
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
        peripheral.discoverServices([CBUUID(string: serviceUUID)])
        //peripheral.discoverServices(nil)
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        self.cleanUp()
        btnConnect.title = "Connect"
        self.isConnected = false
        devices.removeAll()
        deviceTable.reloadData()
        deviceTable.isUserInteractionEnabled = true
        self.connectionIndicator.backgroundColor = UIColor.red
        testConnectionView.isHidden = false
        self.centralManagerDidUpdateState(self.centralManager!)
        self.scanActivityIndecator.isHidden = true
        self.scanActivityIndecator.startAnimating()
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
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
        for characteristic in service.characteristics! {
            self.discoveredPeripheral?.setNotifyValue(true, for: characteristic)
            print("characteristics: \(characteristic.uuid.uuidString) for service: \(service.uuid.uuidString) ")
            
        }
        testConnectionView.isHidden = false
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic)
        tfReceivedChars.text = tfReceivedChars.text! + " " + String(data: characteristic.value!, encoding: .utf8)!
    }
    @IBAction func actionSend(_ sender: Any) {
        var myService:CBService!
        var myCharac:CBCharacteristic!
        for service in (self.discoveredPeripheral?.services)! {
            if service.uuid.uuidString == serviceUUID {
                myService = service
                for characterictic in service.characteristics! {
                    if characterictic.uuid.uuidString == rxCharUUID {
                        myCharac = characterictic
                    }
                }
            }
        }
        //var num:Int = 1
        print(tfSendContent.text!)
        let data = tfSendContent.text!.data(using: .utf8)
        self.discoveredPeripheral?.writeValue(data!, for: myCharac, type: CBCharacteristicWriteType.withoutResponse)
        //self.discoveredPeripheral?.readValue(for: myCharac)
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
