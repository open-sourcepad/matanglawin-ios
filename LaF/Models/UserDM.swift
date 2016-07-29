
import UIKit
import CoreLocation

private let kUserIdKey: String = "id"
private let kNameKey: String = "name"
private let kEmailKey: String = "email"
private let kAuthenticationTokenKey: String = "auth_token"
private let kFacebookIdKey: String = "facebook_id"
private let kUserDefaults: String = "defaults saved user"


class UserDM: NSObject {
    var userId: Int?
    var name: String?
    var email: String?

    var facebook_id: String?
    var authenticationToken: String?


    override init() {
        self.userId = 0
        self.name = ""
        self.email = ""
        self.authenticationToken = ""
        self.facebook_id = ""
    }
    
    init(coder aDecoder: NSCoder!) {
        self.userId = aDecoder.decodeObjectForKey(kUserIdKey) as? Int
        self.name = aDecoder.decodeObjectForKey(kNameKey) as? String
        self.email = aDecoder.decodeObjectForKey(kEmailKey) as? String
        self.authenticationToken = aDecoder.decodeObjectForKey(kAuthenticationTokenKey) as? String
        self.facebook_id = aDecoder.decodeObjectForKey(kFacebookIdKey) as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(self.userId, forKey: kUserIdKey)
        aCoder.encodeObject(self.name, forKey: kNameKey)
        aCoder.encodeObject(self.email, forKey: kEmailKey)
        aCoder.encodeObject(self.authenticationToken, forKey: kAuthenticationTokenKey)
        aCoder.encodeObject(self.facebook_id, forKey: kFacebookIdKey)
    }
    
    class func saveActiveUser(user: UserDM?) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(user!)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: kUserDefaults)
    }
    
    class func getActiveUser() -> UserDM {
        let data = NSUserDefaults.standardUserDefaults().dataForKey(kUserDefaults)
        let dict = NSKeyedUnarchiver.unarchiveObjectWithData(data!)
        
        var user: UserDM = UserDM()
        user = dict as! UserDM
        
        return user
    }
    
    class func userFromData(data: AnyObject, user: UserDM?) -> UserDM {
        var userVar = user
        if userVar == nil { userVar = UserDM() }
        
        if let dict = data as? NSDictionary {
            if let dataDict = dict.objectForKey("data") as? NSDictionary {
                userVar!.userId = dataDict.objectForKey(kUserIdKey) as? Int
                userVar!.name = dataDict.objectForKey(kNameKey) as? String
                userVar!.email = dataDict.objectForKey(kEmailKey) as? String
                userVar!.authenticationToken = dataDict.objectForKey(kAuthenticationTokenKey) as? String
                userVar!.facebook_id = dataDict.objectForKey(kFacebookIdKey) as? String
            }
        }
        return userVar!
    }
}
