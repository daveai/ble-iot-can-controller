import UIKit
/*extension UIViewController {
    private struct NotificationViewStruct {
        static var notificationView:UIView?
    }
    var notificationView:UIView {
        get {
            return NotificationViewStruct.notificationView!
        }
        set {
            NotificationViewStruct.notificationView = newValue
        }
    }
    func makeNotificationBarButton(viewController:UIViewController){
        let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 16))
        button1.setImage(UIImage(named: "envelop"), for: UIControlState.normal)
        let label = UILabel(frame: CGRect(x: button1.frame.width, y: -10, width: 20, height: 20))
        label.font = UIFont(name: "PT Sans", size: 12)
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.textColor = .white
        label.backgroundColor = .red
        label.text = "80"
        button1.addSubview(label)
        let envelopButton = UIBarButtonItem(customView: button1)
        viewController.navigationItem.rightBarButtonItems?.append(envelopButton)
        button1.addTarget(self, action: #selector(showNotification(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dashboardViewTapped)))
    }
    @objc func showNotification(sender:UIButton){
        print(sender.frame)
        var isViewPresent = false
        for aview in self.view.subviews {
            if aview.tag == 500 {
                isViewPresent = true
            } else {
                isViewPresent = false
            }
        }
        if isViewPresent{            
            self.view.bringSubview(toFront: notificationView)
            
        } else {
            notificationView = NotificationListView(frame: CGRect(x: (sender.frame.origin.x) - 275, y: ((sender.frame.origin.y) + 30), width: 300, height: 250))
            notificationView.tag = 500
            self.view.addSubview(notificationView)
            self.view.bringSubview(toFront: notificationView)
        }
    }
    @objc func dashboardViewTapped(){
        notificationView.removeFromSuperview()
    }
}*/
