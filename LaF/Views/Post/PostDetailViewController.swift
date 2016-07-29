import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

private let kElementHeight: CGFloat = 30.0

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
        obj.text = self.post.name;
        
        return obj
    }()
    
    lazy var descriptionLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(0, self.nameLabel.frame.origin.y + kElementHeight, self.view.frame.size.width, kElementHeight))
        obj.text = self.post.desc;
        
        return obj
    }()

    lazy var contactPersonLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(0, self.descriptionLabel.frame.origin.y + kElementHeight, self.view.frame.size.width, kElementHeight))
        obj.text = self.post.contact;
        return obj
    }()

    lazy var contactNumberLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(0, self.contactPersonLabel.frame.origin.y + kElementHeight, self.view.frame.size.width, kElementHeight))
        
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Colors.colorThemeLightGray;
        self.title = "Details"

        let burger = UIButton()
        burger.setTitle("Back", forState: .Normal)
        burger.frame = CGRectMake(0, 0, 80, 50)
        burger.addTarget(self, action: Selector("backAction"), forControlEvents: .TouchUpInside)
        
        //.... Set Right/Left Bar Button item
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = burger
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        
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