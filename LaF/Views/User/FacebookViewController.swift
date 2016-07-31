import UIKit
import Alamofire
import SwiftyJSON

class FacebookViewController: UIViewController, FacebookControllerDelegate  {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    lazy var loginButon: MainButton = {
        var obj = MainButton(frame: CGRectMake(30, (self.view.frame.size.height/2), self.view.frame.size.width - 60, 50));
        obj.setTitle("Login via Facebook", forState: .Normal)
        obj.addTarget(self, action: Selector("loginButtonAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var photo: UIImageView = {
        let obj: UIImageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        obj.backgroundColor = UIColor.lightGrayColor()
        obj.image = UIImage(named: "mosaic")
        obj.contentMode = UIViewContentMode.Center
        return obj
    }()

    lazy var finderLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(0,  (self.view.frame.size.height/2)-120, self.view.frame.size.width, 100))
        obj.text = "Lost or Found someone? Post it here!"
        obj.textAlignment = NSTextAlignment.Center
        obj.backgroundColor = Constants.Colors.colorTheme
        obj.textColor = Constants.Colors.colorFontReg
        obj.font = UIFont(name: obj.font.fontName, size: 20.0)

        return obj
    }()

    lazy var loadingLabel: UILabel = {
        let obj: UILabel = UILabel(frame: self.loginButon.frame)
        obj.text = "Loading..."
        obj.textAlignment = NSTextAlignment.Center
        obj.backgroundColor = Constants.Colors.colorTheme
        obj.textColor = Constants.Colors.colorFontReg
        obj.hidden = true
        
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Constants.Colors.colorTheme
        self.navigationController?.navigationBarHidden = true;

        self.view.addSubview(photo)
        self.view.addSubview(loginButon)
        self.view.addSubview(finderLabel)
        self.view.addSubview(loadingLabel)
    }
 
    func connectFacebookDidFail() {
        print("Callback")
    }
    
    func loginButtonAction() {
        FacebookController.connectFacebook(self.parentViewController!, delegate: self)
    }

    func connectFacebookDidFinish(user: UserDM) {
        signup(user)
        self.loadingLabel.hidden = false
        self.loginButon.hidden = true
    }

    func signup(user: UserDM) {
        let params = [
            "user[first_name]": user.first_name!,
            "user[last_name]": user.last_name!,
            "user[email]": user.email!,
            "user[uid]": user.uid!,
            "user[provider]": "facebook",
        ]

        Alamofire.request(.POST, Constants.API.signup, parameters: params)
            .validate()
            .responseJSON { response in
                let json = JSON(response.result.value!)
                let obj: UserDM = UserDM();
                obj.first_name = json["user"]["first_name"].stringValue
                obj.last_name = json["user"]["last_name"].stringValue
                obj.email = json["user"]["email"].stringValue
                obj.userId = json["user"]["id"].intValue
                obj.authenticationToken = json["user"]["auth_token"].stringValue
                
                UserDM.saveActiveUser(obj)
                self.appDelegate.currentUser = obj
                
                self.appDelegate.window?.rootViewController = self.appDelegate.mainNavigation

        }
    }
}