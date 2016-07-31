import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

private let kElementHeight: CGFloat = 40.0

class PostDetailViewController: TemplateViewController, UIScrollViewDelegate , LostTableViewDelegate {
    
    var post: PostDM = PostDM();

    lazy var photo: UIImageView = {
        let obj: UIImageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2))
        obj.backgroundColor = UIColor.lightGrayColor()
//        obj.contentMode = UIViewContentMode.ScaleAspectFit    
        obj.sd_setImageWithURL(NSURL(string: self.post.image_url!))
        return obj
    }()
    
    lazy var nameLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(0, self.photo.frame.size.height, self.view.frame.size.width, kElementHeight))
        obj.textAlignment = NSTextAlignment.Center
        obj.text = self.post.name;
        obj.textColor = Constants.Colors.colorFontTitle
        obj.font = UIFont(name: obj.font.fontName, size: 30.0)
        
        return obj
    }()

    lazy var contactPersonLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(0, self.nameLabel.frame.origin.y + kElementHeight, self.view.frame.size.width, kElementHeight))
        obj.text = "Contact# \(self.post.contact!)";
        obj.textColor = Constants.Colors.colorFontReg
        obj.textAlignment = NSTextAlignment.Center
        return obj
    }()

    lazy var descriptionLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(0, self.contactPersonLabel.frame.origin.y + kElementHeight, self.view.frame.size.width, kElementHeight))
        obj.textAlignment = NSTextAlignment.Center
        obj.textColor = Constants.Colors.colorFontReg
        obj.text = self.post.desc;
        
        return obj
    }()

    lazy var contactNumberLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(0, self.descriptionLabel.frame.origin.y + kElementHeight, self.view.frame.size.width, kElementHeight))
        obj.textAlignment = NSTextAlignment.Center
        obj.textColor = Constants.Colors.colorFontReg
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"

//        let barButton = UIBarButtonItem(image: UIImage(named: "back"),
//            style: UIBarButtonItemStyle.Plain ,
//            target: self, action: "backAction:")
//        barButton.tintColor = UIColor.whiteColor()
//        self.navigationItem.hidesBackButton = true
//        self.navigationItem.leftBarButtonItem = barButton
        
        
        self.view.addSubview(photo)
        self.view.addSubview(nameLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(contactPersonLabel)
        self.view.addSubview(contactNumberLabel)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.title = self.post.mytype
    }
    
    func backAction() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}