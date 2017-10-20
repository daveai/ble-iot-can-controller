//
//  ListTicketsViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 10/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
class ListTicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum ControllersSegue: String {
        case editTicket = "editTicket"
    }
    @IBOutlet weak var ticketListTable: UITableView!    
    @IBOutlet weak var btnPast: CustomUIButton!
    @IBOutlet weak var btnUpcoming: CustomUIButton!
    @IBOutlet weak var btnCurrent: CustomUIButton!
    var currentTicket:[[String:String]] = [
        ["name":"Maks Dovgan",
         "address":"50 Armstrong Turnpike",
        "job_id":"123500",
        "mix_design": "$ 1700",
        "yards":"20",
        "time_requested":"15 Nov 2017"],
        ["name":"Ernest Williamson",
         "address":"8791 Lindgren Course Apt. 878",
         "job_id":"123600",
         "mix_design": "$ 2950",
         "yards":"40",
         "time_requested":"15 Nov 2017"]
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultTab()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableView
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTicket.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "cell"
        var cell: TicketListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? TicketListTableViewCell
        if cell == nil {
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TicketListTableViewCell
        }
        cell.customerName.text = currentTicket[indexPath.row]["name"]
        cell.address.text = currentTicket[indexPath.row]["address"]
        cell.jobID.text = currentTicket[indexPath.row]["job_id"]
        cell.mixDesign.text = currentTicket[indexPath.row]["mix_design"]
        cell.yards.text = currentTicket[indexPath.row]["yards"]
        cell.timeRequested.text = currentTicket[indexPath.row]["time_requested"]
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66.0
    }*/
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == ControllersSegue.editTicket.rawValue){
            
            let _ = segue.destination as! EditTicketViewController
            
        }
    }
    
    func deSelectAllTabs(){
        btnCurrent.setImage(UIImage(imageLiteralResourceName: "current_tab_inactive"), for: UIControlState.normal)
        btnUpcoming.setImage(UIImage(imageLiteralResourceName: "upcoming_tab_inactive"), for: UIControlState.normal)
        btnPast.setImage(UIImage(imageLiteralResourceName: "past_tab_inactive"), for: UIControlState.normal)
    }
    func setDefaultTab(){
        btnCurrent.setImage(UIImage(imageLiteralResourceName: "current_tab_active"), for: UIControlState.normal)
    }
    @IBAction func actionCurrent(_ sender: Any) {
        currentTicket = [
            ["name":"Maks Dovgan",
             "address":"50 Armstrong Turnpike",
             "job_id":"123500",
             "mix_design": "$ 1700",
             "yards":"20",
             "time_requested":"15 Nov 2017"],
            ["name":"Ernest Williamson",
             "address":"8791 Lindgren Course Apt. 878",
             "job_id":"123600",
             "mix_design": "$ 2950",
             "yards":"40",
             "time_requested":"15 Nov 2017"]
            
        ]
        self.ticketListTable.reloadData()
        deSelectAllTabs()
        btnCurrent.setImage(UIImage(imageLiteralResourceName: "current_tab_active"), for: UIControlState.normal)
    }
    
    @IBAction func actionUpcoming(_ sender: Any) {
        self.currentTicket = [
            ["name":"David Heath",
             "address":"50 Newyork, NY",
             "job_id":"123300",
             "mix_design": "$ 3000",
             "yards":"10",
             "time_requested":"15 DEC 2017"],
            ["name":"Ethan Carter",
             "address":"52 Mayami, FL",
             "job_id":"123100",
             "mix_design": "$ 7850",
             "yards":"100",
             "time_requested":"18 DEC 2017"]
            
        ]
        self.ticketListTable.reloadData()
        deSelectAllTabs()
        btnUpcoming.setImage(UIImage(imageLiteralResourceName: "upcoming_tab_active"), for: UIControlState.normal)
    }
    
    @IBAction func actionPast(_ sender: Any) {        
        self.currentTicket = [
            ["name":"Gareth Bale",
             "address":"50 Honolulu, HI",
             "job_id":"123300",
             "mix_design": "$ 5200",
             "yards":"20",
             "time_requested":"15 Nov 2016"],
            ["name":"Kane Richardson",
             "address":"52 Bellinghton Road",
             "job_id":"123400",
             "mix_design": "$ 4598",
             "yards":"50",
             "time_requested":"18 Nov 2016"]
            
        ]
        self.ticketListTable.reloadData()
        deSelectAllTabs()
        btnPast.setImage(UIImage(imageLiteralResourceName: "past_tab_active"), for: UIControlState.normal)
    }
}
