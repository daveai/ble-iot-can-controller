//
//  ListTicketsViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 10/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
class ListTicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TicketListTableViewCellDelegate, AddNotePopupDelegete {
    
    
    enum ControllersSegue: String {
        case editTicket = "toEditTicket"
        case createTicket = "toCreateTicket"
        case navigation = "toNavigation"
    }
    @IBOutlet weak var ticketListTable: UITableView!    
    @IBOutlet weak var btnPast: CustomUIButton!
    @IBOutlet weak var btnUpcoming: CustomUIButton!
    @IBOutlet weak var btnCurrent: CustomUIButton!
    @IBOutlet var noteView: AddNote!
    var currentTicket:[[String:Any]] = [
        ["name":"Maks Dovgan",
         "address":"50 Armstrong Turnpike",
        "job_id":"123500",
        "mix_design": "$ 1700",
        "yards":"20",
        "status":"current",
        "is_critical":true,
        "time_requested":"15 Nov 2017"],
        ["name":"Ernest Williamson",
         "address":"8791 Lindgren Course Apt. 878",
         "job_id":"123600",
         "mix_design": "$ 2950",
         "yards":"40",
         "status":"current",
         "is_critical":false,
         "time_requested":"15 Nov 2017"]
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultTab()
        ticketListTable.delaysContentTouches = true
        ticketListTable.canCancelContentTouches = true
        noteView.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
        cell.customerName.text = (currentTicket[indexPath.row]["name"] as! String)
        cell.address.titleLabel?.text = (currentTicket[indexPath.row]["address"] as! String)
        cell.jobID.text = (currentTicket[indexPath.row]["job_id"] as! String)
        cell.mixDesign.text = (currentTicket[indexPath.row]["mix_design"] as! String)
        cell.yards.text = (currentTicket[indexPath.row]["yards"] as! String)
        cell.timeRequested.text = (currentTicket[indexPath.row]["time_requested"] as! String)
        if((currentTicket[indexPath.row]["is_critical"] as! Bool) == true){
            cell.btnCritical.isHidden = false
        } else {
            cell.btnCritical.isHidden = true
        }
        if((currentTicket[indexPath.row]["status"] as! String) == "current"){
            cell.btnSend.isHidden = false
        } else {
            cell.btnSend.isHidden = true
        }
        cell.delegate = self
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }    
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
             "status":"current",
             "is_critical":true,
             "time_requested":"15 Nov 2017"],
            ["name":"Ernest Williamson",
             "address":"8791 Lindgren Course Apt. 878",
             "job_id":"123600",
             "mix_design": "$ 2950",
             "yards":"40",
             "status":"current",
             "is_critical":false,
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
             "status":"upcoming",
             "is_critical":false,
             "time_requested":"15 DEC 2017"],
            ["name":"Ethan Carter",
             "address":"52 Mayami, FL",
             "job_id":"123100",
             "mix_design": "$ 7850",
             "yards":"100",
             "status":"upcoming",
             "is_critical":false,
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
             "status":"past",
             "is_critical":false,
             "time_requested":"15 Nov 2016"],
            ["name":"Kane Richardson",
             "address":"52 Bellinghton Road",
             "job_id":"123400",
             "mix_design": "$ 4598",
             "yards":"50",
             "status":"past",
             "is_critical":false,
             "time_requested":"18 Nov 2016"]
            
        ]
        self.ticketListTable.reloadData()
        deSelectAllTabs()
        btnPast.setImage(UIImage(imageLiteralResourceName: "past_tab_active"), for: UIControlState.normal)
    }
    func didSelectARowWithScrollView(selectedRow: TicketListTableViewCell) {
        self.performSegue(withIdentifier: ControllersSegue.editTicket.rawValue, sender: nil)
    }
    func didCriticalPressed(selectedRow: TicketListTableViewCell) {
        noteView.center = CGPoint(x: self.view.frame.size.width  / 2, y: self.view.frame.size.height / 2)
        self.view.addSubview(noteView)
    }
    func didNoteAdded(note: String) {
        
    }
    
    func didAddNotePopupClose() {
        noteView.removeFromSuperview()
    }
}
