import UIKit
import Alamofire
import SwiftyJSON


class LostTableView: UIView, UITableViewDelegate, UITableViewDataSource, PostCellDelegate  {
    
    var delegate: AnyObject?
    
    lazy var tableView: UITableView = {
        var obj = UITableView();
        obj.delegate = self;
        obj.delegate      =   self
        obj.dataSource    =   self
        obj.registerClass(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        return obj
    }()

    var posts: [PostDM] = []

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.frame =   CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.backgroundColor = UIColor.whiteColor()

        self.addSubview(self.tableView)
        getPost()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getPost() {
        Alamofire.request(.GET, Constants.API.lost, parameters: ["foo": "bar"])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let json = JSON(response.result.value!)
                    for (_, subJson) in json {
                        let obj: PostDM = PostDM();
                        obj.name = subJson["name"].stringValue
                        obj.picture = subJson["picture"].stringValue
                        self.posts.append(obj)
                        
                    }
                    
                    print(self.posts)
                    self.tableView.reloadData()

                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    /*
        delegates
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.tableView.rowHeight = 100
        let cell: PostCell = PostCell.init(style: .Default, reuseIdentifier: "PostCell")

        cell.setCellData(self.posts[indexPath.row])
        cell.delegate = self
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        delegate?.lostTablePostCell!(self, postCellDidTap: self.posts[indexPath.row])
    }

}



@objc protocol LostTableViewDelegate {
    optional func lostTablePostCell(tableView: LostTableView, postCellDidTap sender: AnyObject)
}