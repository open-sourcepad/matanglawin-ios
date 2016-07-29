import UIKit
import CoreLocation


class PostDM: NSObject {
    var postId: Int?
    var name: String?
    var age: String?
    var picture: String?
    
    
    override init() {
        self.postId = 0
        self.name = ""
        self.age = ""
        self.picture = ""
    }
}