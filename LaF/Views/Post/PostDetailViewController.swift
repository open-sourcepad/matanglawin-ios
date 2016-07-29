import UIKit
import Alamofire
import SwiftyJSON


class PostDetailViewController: TemplateViewController, UIScrollViewDelegate , LostTableViewDelegate {
    
    var post: PostDM = PostDM();
    
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
    }
    
    func backAction() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}