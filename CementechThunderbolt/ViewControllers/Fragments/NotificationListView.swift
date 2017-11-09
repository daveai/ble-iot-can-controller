//
//  NotificationView.swift
//  CementechThunderbolt
//
//  Created by Debashis  on 07/11/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
class NotificationListView: UIView, UITableViewDataSource, UITableViewDelegate {
    var contentView : UIView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    func xibSetup() {
        contentView = loadViewFromNib()
        contentView!.frame = bounds
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(contentView!)
    }
    func loadViewFromNib() -> UIView! {        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    // MARK: UITableView
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell: NotificationTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? NotificationTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "NotificationTableViewCellView", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? NotificationTableViewCell
        }
        if indexPath.row < 3 {
            cell.backgroundColor = #colorLiteral(red: 0.5792680856, green: 0.8280668782, blue: 0.544665292, alpha: 0.09629173801)
        }
        return cell
    }
    
    
}
