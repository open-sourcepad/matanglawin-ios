import UIKit
import FBSDKLoginKit
import Alamofire
import SwiftyJSON

private var singleton: FacebookController?

class FacebookController: NSObject {
    var delegate: AnyObject?


    private class func getInstance() -> FacebookController {
        if singleton == nil {
            return FacebookController()
        }
        return singleton!
    }

    class func connectFacebook(parentViewController: UIViewController, delegate: AnyObject) {
        
        FBSDKLoginManager().logOut();
        let controller = self.getInstance()
        controller.delegate = delegate
        let loginManager = FBSDKLoginManager();
        loginManager.logInWithReadPermissions(["public_profile", "email"], fromViewController: parentViewController, handler: { (result, error) -> Void in
            if error != nil {
                print(FBSDKAccessToken.currentAccessToken())
            } else if result.isCancelled {
                print("Cancelled")
                delegate.connectFacebookDidFail!()
            } else {
                if((FBSDKAccessToken.currentAccessToken()) != nil){
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                        if (error == nil){
                            let json = JSON(result)
                            
                            let obj: UserDM = UserDM();
                            obj.first_name = json["first_name"].stringValue
                            obj.last_name = json["last_name"].stringValue
                            obj.email = json["email"].stringValue
                            obj.uid = json["id"].stringValue
                            delegate.connectFacebookDidFinish!(obj)
                        }
                    })
                }
                print("LoggedIn")
            }
        })
    }

    
}

@objc protocol FacebookControllerDelegate {
    optional func connectFacebookDidFail()
    optional func connectFacebookDidFinish(user: UserDM)
}