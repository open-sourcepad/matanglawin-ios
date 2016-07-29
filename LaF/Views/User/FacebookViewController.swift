import UIKit
import FBSDKLoginKit
import Alamofire

class FacebookViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        FBSDKLoginManager().logOut();
        let loginManager = FBSDKLoginManager();
        loginManager.logInWithReadPermissions(["public_profile", "email"], fromViewController: self.parentViewController, handler: { (result, error) -> Void in
            if error != nil {
                print(FBSDKAccessToken.currentAccessToken())
            } else if result.isCancelled {
                print("Cancelled")
            } else {
                print("LoggedIn")
            }
        })
    }
    
    func signup() {
        Alamofire.request(.POST, "http://localhost:3000", parameters: ["foo": "bar"])
            .validate()
            .responseJSON { response in
                print(response)
            }
    }
    
}