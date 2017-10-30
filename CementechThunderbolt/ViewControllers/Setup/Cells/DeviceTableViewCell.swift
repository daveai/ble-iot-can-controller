//
//  DeviceTableViewCell.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 30/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    @IBOutlet weak var deviceUUID: UILabel!
    @IBOutlet weak var deviceName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
