import UIKit
import Alamofire
import SwiftyJSON


class LostTableView: UIView, UITableViewDelegate, UITableViewDataSource, PostCellDelegate  {
    
    var delegate: AnyObject?

    lazy var refreshControl: UIRefreshControl = {
        var obj = UIRefreshControl();
        obj.addTarget(self, action: "refreshAction:", forControlEvents: UIControlEvents.ValueChanged)
        obj.tintColor = Constants.Colors.colorFontReg

        return obj
    }()

    lazy var tableView: UITableView = {
        var obj = UITableView();
        obj.delegate = self;
        obj.delegate      =   self
        obj.dataSource    =   self
        obj.registerClass(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        obj.addSubview(self.refreshControl)
        return obj
    }()

    var posts: [PostDM] = []
    var post: PostDM = PostDM()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.frame =   CGRectMake(0, 0, frame.size.width, frame.size.height);
        tableView.separatorColor = UIColor.blackColor()
        tableView.backgroundColor = UIColor.clearColor()
        self.backgroundColor = Constants.Colors.colorTheme
        self.addSubview(self.tableView)
        self.refreshControl.beginRefreshing()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func assignPost(post: PostDM) {
        self.post = post
        getPost()
    }

    func getPost() {
        print(UserDM.getActiveUser().authenticationToken!)
        Alamofire.request(.GET, Constants.API.lost, headers:
            ["AuthToken": UserDM.getActiveUser().authenticationToken!], parameters: ["id": self.post.postId!])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    self.posts = []
                    let json = JSON(response.result.value!)["collection"]
                    print(json)
                    for (_, subJson) in json {
                        let obj: PostDM = PostDM();
                        obj.postId = subJson["id"].intValue
                        obj.name = subJson["name"].stringValue
                        obj.desc = subJson["description"].stringValue
                        obj.contact = subJson["contact"].stringValue
                        obj.lambdal_id = subJson["lambdal_id"].stringValue
                        obj.nickname = subJson["nickname"].stringValue
                        obj.birthday = subJson["birthday"].stringValue
                        obj.age = subJson["age"].intValue
                        obj.created_at = subJson["created_at"].stringValue
                        obj.updated_at = subJson["updated_at"].stringValue
                        obj.mytype = subJson["mytype"].stringValue
                        obj.image_url = subJson["image_url"].stringValue
                        obj.match = subJson["match"].stringValue
                        self.posts.append(obj)
                        
                    }
                    
                    print(self.posts)
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()

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
    
    func refreshAction(sender:AnyObject) {
        getPost()
    }

}



@objc protocol LostTableViewDelegate {
    optional func lostTablePostCell(tableView: LostTableView, postCellDidTap sender: AnyObject)
}