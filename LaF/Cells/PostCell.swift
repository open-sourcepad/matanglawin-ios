import UIKit
import SDWebImage


class PostCell: UITableViewCell {

    var delegate: AnyObject?

    lazy var photo: UIImageView = {
        let obj: UIImageView = UIImageView(frame: CGRectMake(10, 10, 80, 80))
        obj.backgroundColor = UIColor.lightGrayColor()
        return obj
    }()

    lazy var nameLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(110, 10, 200, 30))
        
        return obj
    }()

    lazy var percentLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(110, 50, 200, 30))
        
        return obj
    }()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - View methods
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .Gray

        self.addSubview(photo);
        self.addSubview(nameLabel);
        self.addSubview(percentLabel);
        


        // Extend separator to edge
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

    //MARK: - Public methods
    func setCellData(post: PostDM){
        nameLabel.text = post.name;
        percentLabel.text = "60% alike"
        handleImage(post.image_url!)
    }
    
    func handleImage(url: String) {
        photo.sd_setImageWithURL(NSURL(string: url))
    }
}

@objc protocol PostCellDelegate {
    optional func postCell(cell: PostCell, postCellDidTap sender: AnyObject)
}