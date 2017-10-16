import UIKit
import LayerUIExtention
protocol AddNotePopupDelegete {
    func didNoteAdded(note:String)
    func didAddNotePopupClose()
}
class AddNote: UIView {
    var delegate:AddNotePopupDelegete!
    
    @IBOutlet var txtNode: CustomUITextField!
    var contentView:UIView?
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
        
        
    }
    @IBAction func actionAddNote(_ sender: Any) {
        delegate.didNoteAdded(note: txtNode.text!)
    }
    
    @IBAction func actionClose(_ sender: Any) {
        delegate.didAddNotePopupClose()
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
}
