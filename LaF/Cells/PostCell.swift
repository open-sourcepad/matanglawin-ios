import UIKit
import SDWebImage


class PostCell: UITableViewCell {

    var delegate: AnyObject?

    lazy var photo: UIImageView = {
        let obj: UIImageView = UIImageView(frame: CGRectMake(25, 10, 80, 80))
        obj.backgroundColor = Constants.Colors.colorFontReg
//        obj.contentMode = UIViewContentMode.ScaleAspectFit
        obj.layer.cornerRadius = 40.0
        obj.clipsToBounds = true
        return obj
    }()

    lazy var nameLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(125, 20, 200, 30))
        obj.textColor = Constants.Colors.colorFontTitle
        obj.font = UIFont(name: obj.font.fontName, size: 20.0)
        return obj
    }()

    lazy var percentLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(self.nameLabel.frame.origin.x, 50, self.nameLabel.frame.size.width, 15))
        obj.textColor = Constants.Colors.colorFontReg
        obj.font = UIFont(name: obj.font.fontName, size: 15.0)
        return obj
    }()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - View methods
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = Constants.Colors.colorTheme
        self.selectionStyle = .None

        self.addSubview(photo);
        self.addSubview(nameLabel);
        self.addSubview(percentLabel);

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
        handleImage(post.image_url!)
        computePercent(post)
    }
    
    func handleImage(url: String) {
        photo.sd_setImageWithURL(NSURL(string: url))
    }
    
    func computePercent(post: PostDM) {
        if((post.match! ?? "").isEmpty) {
            // do nothing
        }else {
            let percent: Double = Double(post.match!)! * 100.0
            self.percentLabel.text = "\(percent)% match"
        }

    }
}

@objc protocol PostCellDelegate {
    optional func postCell(cell: PostCell, postCellDidTap sender: AnyObject)
}