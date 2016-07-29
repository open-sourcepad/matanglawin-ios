import UIKit
import Alamofire
import SwiftyJSON


class PostsViewController: TemplateViewController, UIScrollViewDelegate , LostTableViewDelegate, FoundTableViewDelegate {
    var post: PostDM = PostDM();

    lazy var scrollView: UIScrollView = {
        var obj = UIScrollView(frame: CGRectMake(0,0, self.view.frame.size.width * 2,  self.view.frame.size.height));
        obj.delegate = self;
        
        return obj
    }()
    
    lazy var lostTableView: LostTableView = {
        var obj = LostTableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height));
        obj.delegate = self;
        return obj
    }()
    
    lazy var foundTableView: FoundTableView = {
        var obj = FoundTableView(frame: CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height));
        obj.delegate = self;
        return obj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        scrollView.addSubview(lostTableView)
        scrollView.addSubview(foundTableView)
    }
    
    override func viewDidAppear(animated: Bool) {
        print(self.post.postId)
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
    
}