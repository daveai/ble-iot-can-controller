//
//  TicketListTableViewCell.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 10/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit

class TicketListTableViewCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
