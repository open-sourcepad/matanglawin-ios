import UIKit
import CoreLocation


class PostDM: NSObject {
    var postId: Int?
    var name: String?
    var desc: String?
    var contact: String?
    var lambdal_id: String?
    var nickname: String?
    var birthday: String?
    var age: Int?
    var created_at: String?
    var updated_at: String?
    var mytype: String?
    var image_url: String?
    var match: String?
    
    override init() {
        self.postId = 0
        self.name = ""
        self.desc = ""
        self.contact = ""
        self.lambdal_id = ""
        self.nickname = ""
        self.birthday = ""
        self.age = 0
        self.created_at = ""
        self.updated_at = ""
        self.mytype = ""
        self.image_url = ""
        self.match = ""
    }
}