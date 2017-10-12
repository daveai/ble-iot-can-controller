//
//  ListTicketsViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 10/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit

class ListTicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum ControllersSegue: String {
        case editTicket = "editTicket"
    }
    @IBOutlet weak var ticketListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableView
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "cell"
        var cell: TicketListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? TicketListTableViewCell
        if cell == nil {
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TicketListTableViewCell
        }
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 66))
        view.backgroundColor = #colorLiteral(red: 0.9380011602, green: 0.9380011602, blue: 0.9380011602, alpha: 1)
        let label = UILabel(frame: CGRect(x: 48, y: 20, width: tableView.frame.width, height: 20))
        view.addSubview(label)
        if(section == 0){
            label.text = "Current"
        } else {
            label.text = "Past"            
        }
        return view
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == ControllersSegue.editTicket.rawValue){
            
            let _ = segue.destination as! EditTicketViewController
            
        }
    }

}
