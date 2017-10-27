//
//  LeftMenuViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 06/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
struct StoryBoard {
    var storyBoardName:String
    var display:String
}
protocol MenuItemDelegate {
    func didSelectMenu(menu:StoryBoard)
    func didLogout()
}
class LeftMenuView: UIView, UITableViewDelegate, UITableViewDataSource {
    var delegate:MenuItemDelegate?
    var contentView : UIView?
    var selectedMenu : LeftMenuTableViewCell?
    @IBOutlet weak var menuTableView: UITableView!
    var menuItems:[StoryBoard] = [] {
        didSet {
            menuTableView.reloadData()
        }
    }
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
        
        // use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Make the view stretch with containing view
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
        
        menuTableView.backgroundColor = UIColor.clear
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        let border = CALayer()
        border.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.17).cgColor
        border.frame = CGRect(x: self.frame.size.width - 1, y: 0, width: 1.0, height: view.frame.size.height)
        view.layer.addSublayer(border)
        return view
    }
    
    // MARK: UITableView
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "cell"
        var cell: LeftMenuTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftMenuTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "LeftMenuCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LeftMenuTableViewCell
        }
        cell.menuName.text = menuItems[indexPath.row].display
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundView = UIView()
        cell.selectedBackgroundView = UIView()
        if(indexPath.row == 0){
            cell.selectionTriangle.isHidden = false
            self.selectedMenu = cell
        }
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        if ( self.selectedMenu != nil){
            self.selectedMenu?.selectionTriangle.isHidden = true
        }
        self.selectedMenu = self.menuTableView.cellForRow(at: indexPath) as? LeftMenuTableViewCell
        self.selectedMenu?.selectionTriangle.isHidden = false
        delegate?.didSelectMenu(menu: menuItems[indexPath.row])
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        delegate?.didLogout()
    }
}
