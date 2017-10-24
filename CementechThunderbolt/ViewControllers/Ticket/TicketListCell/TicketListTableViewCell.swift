//
//  TicketListTableViewCell.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 10/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
protocol TicketListTableViewCellDelegate {
    func didSelectARowWithScrollView(selectedRow:TicketListTableViewCell)
    func didCriticalPressed(selectedRow:TicketListTableViewCell)
}
class TicketListTableViewCell: UITableViewCell {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var address: UIButton!
    @IBOutlet weak var jobID: UILabel!
    @IBOutlet weak var mixDesign: UILabel!
    @IBOutlet weak var yards: UILabel!
    @IBOutlet weak var timeRequested: UILabel!
    @IBOutlet weak var btnCritical: UIButton!
    var delegate:TicketListTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        scrollView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func handleTap(sender: UIGestureRecognizer) {        
        delegate?.didSelectARowWithScrollView(selectedRow: self)
    }
    
    @IBAction func actionCriticalPressed(_ sender: Any) {
        delegate?.didCriticalPressed(selectedRow: self)
    }
    

}
