import UIKit
import Alamofire
import SwiftyJSON


class HomeViewController: TemplateViewController, UIScrollViewDelegate , LostTableViewDelegate {

    lazy var scrollView: UIScrollView = {
        var obj = UIScrollView();
        obj.delegate = self;
        
        return obj
    }()

    lazy var lostTableView: LostTableView = {
        var obj = LostTableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height));
        obj.delegate = self;
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(lostTableView)
    }
    
    func lostTablePostCell(tableView: LostTableView, postCellDidTap sender: AnyObject) {
        print(sender)
    }

}