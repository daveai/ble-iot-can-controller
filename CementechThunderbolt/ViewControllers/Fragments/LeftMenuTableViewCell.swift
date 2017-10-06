//
//  LeftMenuTableViewCell.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 06/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var selectionTriangle: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
