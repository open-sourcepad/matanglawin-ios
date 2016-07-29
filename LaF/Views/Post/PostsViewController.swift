import UIKit
import Alamofire
import SwiftyJSON

private let kButtonHeight: CGFloat = 30.0

class PostsViewController: TemplateViewController, UIScrollViewDelegate , LostTableViewDelegate, FoundTableViewDelegate {
    var post: PostDM = PostDM();

    lazy var scrollView: UIScrollView = {
        var obj = UIScrollView(frame: CGRectMake(0,kButtonHeight, self.view.frame.size.width * 2,  self.view.frame.size.height-(kButtonHeight + (self.navigationController?.navigationBar.frame.size.height)!)));
        obj.delegate = self;
        obj.scrollEnabled = true;
        
        return obj
    }()
    
    lazy var lostTableView: LostTableView = {
        var obj = LostTableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.scrollView.frame.size.height));
        obj.delegate = self;
        return obj
    }()
    
    lazy var foundTableView: FoundTableView = {
        var obj = FoundTableView(frame: CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.scrollView.frame.size.height));
        obj.delegate = self;
        return obj
    }()
    
    lazy var buttonsView: UIView = {
       var obj = UIView(frame: CGRectMake(0,0, self.view.frame.size.width, kButtonHeight))
        return obj
    }()

    lazy var lostButton: UIButton = {
        var obj = UIButton(frame: CGRectMake(0, 0, self.view.frame.size.width/2, kButtonHeight));
        obj.backgroundColor = Constants.Colors.colorThemeMainBG
        obj.setTitleColor(Constants.Colors.colorTheme, forState: .Normal)
        obj.setTitle("Lost", forState: .Normal)
        obj.addTarget(self, action: Selector("lostButtonAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var foundButton: UIButton = {
        var obj = UIButton(frame: CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, kButtonHeight));
        obj.backgroundColor = Constants.Colors.colorThemeLightGray
        obj.setTitleColor(Constants.Colors.colorTheme, forState: .Normal)
        obj.setTitle("Found", forState: .Normal)
        obj.addTarget(self, action: Selector("foundButtonAction"), forControlEvents: .TouchUpInside)
        return obj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        self.view.addSubview(buttonsView)
        scrollView.addSubview(lostTableView)
        scrollView.addSubview(foundTableView)
        buttonsView.addSubview(lostButton)
        buttonsView.addSubview(foundButton)
    }
    
    override func viewDidAppear(animated: Bool) {
        print(self.post.postId = 15)
        foundTableView.assignPost(self.post)
        lostTableView.assignPost(self.post)
    }
    
    func lostTablePostCell(tableView: LostTableView, postCellDidTap sender: AnyObject) {
        let vc: PostDetailViewController = PostDetailViewController();
        vc.post = sender as! PostDM;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func foundTablePostCell(tableView: FoundTableView, postCellDidTap sender: AnyObject) {
        let vc: PostDetailViewController = PostDetailViewController();
        vc.post = sender as! PostDM;
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func lostButtonAction() {
        lostButton.backgroundColor = Constants.Colors.colorThemeMainBG
        foundButton.backgroundColor = Constants.Colors.colorThemeLightGray
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func foundButtonAction() {
        foundButton.backgroundColor = Constants.Colors.colorThemeMainBG
        lostButton.backgroundColor = Constants.Colors.colorThemeLightGray
        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
    }
    
}