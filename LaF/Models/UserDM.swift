
import UIKit
import CoreLocation

private let kUserIdKey: String = "id"
private let kFirstNameKey: String = "first_name"
private let kLastNameKey: String = "last_name"
private let kEmailKey: String = "email"
private let kAuthenticationTokenKey: String = "auth_token"
private let kUIDKey: String = "uid"
private let kUserDefaults: String = "defaults saved user"


class UserDM: NSObject {
    var userId: Int?
    var last_name: String?
    var first_name: String?
    var email: String?

    var uid: String?
    var authenticationToken: String?


    override init() {
        self.userId = 0
        self.first_name = ""
        self.last_name = ""
        self.email = ""
        self.authenticationToken = ""
        self.uid = ""
    }
    
    init(coder aDecoder: NSCoder!) {
        self.userId = aDecoder.decodeObjectForKey(kUserIdKey) as? Int
        self.first_name = aDecoder.decodeObjectForKey(kFirstNameKey) as? String
        self.last_name = aDecoder.decodeObjectForKey(kLastNameKey) as? String
        self.email = aDecoder.decodeObjectForKey(kEmailKey) as? String
        self.authenticationToken = aDecoder.decodeObjectForKey(kAuthenticationTokenKey) as? String
        self.uid = aDecoder.decodeObjectForKey(kUIDKey) as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(self.userId, forKey: kUserIdKey)
        aCoder.encodeObject(self.first_name, forKey: kFirstNameKey)
        aCoder.encodeObject(self.last_name, forKey: kLastNameKey)
        aCoder.encodeObject(self.email, forKey: kEmailKey)
        aCoder.encodeObject(self.authenticationToken, forKey: kAuthenticationTokenKey)
        aCoder.encodeObject(self.uid, forKey: kUIDKey)
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
                userVar!.first_name = dataDict.objectForKey(kFirstNameKey) as? String
                userVar!.last_name = dataDict.objectForKey(kFirstNameKey) as? String
                userVar!.email = dataDict.objectForKey(kEmailKey) as? String
                userVar!.authenticationToken = dataDict.objectForKey(kAuthenticationTokenKey) as? String
                userVar!.uid = dataDict.objectForKey(kUIDKey) as? String
            }
        }
        return userVar!
    }
}
