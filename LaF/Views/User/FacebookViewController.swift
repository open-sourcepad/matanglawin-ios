import UIKit
import Alamofire
import SwiftyJSON

class FacebookViewController: UIViewController, FacebookControllerDelegate  {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Constants.Colors.colorTheme
        self.navigationController?.navigationBarHidden = true;
        FacebookController.connectFacebook(self.parentViewController!, delegate: self)
    }
 
    func connectFacebookDidFail() {
        print("Callback")
    }

    func connectFacebookDidFinish(user: UserDM) {
        signup(user)
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