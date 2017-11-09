//
//  ListTicketsViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 10/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import LayerUIExtention
import PKHUD
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
    let overlay = UIView()
    var timer = Timer()
    var shouldAnimateRowBackgroundColorOnAdition = false;
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
         "time_requested":"15 Nov 2017"],
        ["name":"Ernest Williamson",
         "address":"8791 Lindgren Course Apt. 878",
         "job_id":"123600",
         "mix_design": "$ 2950",
         "yards":"40",
         "status":"current",
         "is_critical":false,
         "time_requested":"15 Nov 2017"],
        ["name":"Ernest Williamson",
         "address":"8791 Lindgren Course Apt. 878",
         "job_id":"123600",
         "mix_design": "$ 2950",
         "yards":"40",
         "status":"current",
         "is_critical":false,
         "time_requested":"15 Nov 2017"],
        ["name":"Ernest Williamson",
         "address":"8791 Lindgren Course Apt. 878",
         "job_id":"123600",
         "mix_design": "$ 2950",
         "yards":"40",
         "status":"current",
         "is_critical":false,
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        makeNotificationBarButton(viewController: self)
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
        timer.invalidate()
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
             "time_requested":"15 Nov 2017"],
            ["name":"Ernest Williamson",
             "address":"8791 Lindgren Course Apt. 878",
             "job_id":"123600",
             "mix_design": "$ 2950",
             "yards":"40",
             "status":"current",
             "is_critical":false,
             "time_requested":"15 Nov 2017"],
            ["name":"Ernest Williamson",
             "address":"8791 Lindgren Course Apt. 878",
             "job_id":"123600",
             "mix_design": "$ 2950",
             "yards":"40",
             "status":"current",
             "is_critical":false,
             "time_requested":"15 Nov 2017"],
            ["name":"Ernest Williamson",
             "address":"8791 Lindgren Course Apt. 878",
             "job_id":"123600",
             "mix_design": "$ 2950",
             "yards":"40",
             "status":"current",
             "is_critical":false,
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
             "time_requested":"18 DEC 2017"],
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
             "time_requested":"18 DEC 2017"],
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
        timer = Timer.scheduledTimer(timeInterval: 5, target: self,   selector: (#selector(addARow)), userInfo: nil, repeats: false)
    }
    @objc func addARow(){
        self.shouldAnimateRowBackgroundColorOnAdition = true
        self.currentTicket.insert(["name":"Carlos Kamini",
                                   "address":"78 Mayami, FL",
                                   "job_id":"123100",
                                   "mix_design": "$ 1258",
                                   "yards":"500",
                                   "status":"upcoming",
                                   "is_critical":false,
                                   "time_requested":"18 DEC 2017"], at: 0);
        ticketListTable.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.top)
        let cell = ticketListTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! TicketListTableViewCell
        cell.container.backgroundColor = #colorLiteral(red: 0.5792680856, green: 0.8280668782, blue: 0.544665292, alpha: 0.09629173801)
        UIView.animate(withDuration: 2.0) {
            cell.container.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    @IBAction func actionPast(_ sender: Any) {
        timer.invalidate()
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
        
        overlay.frame = self.view.frame
        overlay.bounds = self.view.bounds
        overlay.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        self.view.addSubview(overlay)
        noteView.center = CGPoint(x: self.view.frame.size.width  / 2, y: self.view.frame.size.height / 2)
        overlay.addSubview(noteView)
    }
    func didNoteAdded(note: String) {
        noteView.removeFromSuperview()
        overlay.removeFromSuperview()
    }
    
    func didAddNotePopupClose() {
        noteView.removeFromSuperview()
        overlay.removeFromSuperview()
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        print("Key board y:", frame.origin.y)
        print("Login button y", self.noteView.frame.origin.y)
        //need to liftup the scrollview
        let displacement = self.noteView.frame.origin.y - frame.origin.y;
        //adding some nitty padding bellow
        let totalDisplacement = displacement + 300
        /*self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.scrollView.contentSize.height + totalDisplacement)
         self.scrollView.setContentOffset(CGPoint(x: 0, y: totalDisplacement), animated: true);*/
        UIView.animate(withDuration: 2.0, animations: {
            self.noteView.frame = CGRect(x: self.noteView.frame.origin.x, y: self.noteView.frame.origin.y - totalDisplacement, width: self.noteView.frame.width, height: self.noteView.frame.height)
        })
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 2.0, animations: {
            self.noteView.center = CGPoint(x: self.view.frame.size.width  / 2, y: self.view.frame.size.height / 2)
        })
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
