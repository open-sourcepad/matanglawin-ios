import Foundation
import UIKit

struct Constants {
    
    struct Sizes {
        static let screenSize   = UIScreen.mainScreen().bounds
        static let windowHeight = UIScreen.mainScreen().bounds.height
        static let windowWidth  = UIScreen.mainScreen().bounds.width
        static let statusHeight = CGFloat(20)
        static let tabbarHeight = CGFloat(49)
        static let contentHeight = windowHeight - (statusHeight + tabbarHeight)
        
        static let homeThumb    = windowWidth / 3
    }
    
    // Constants.Colors.nameOfConstant
    struct Colors {
        static let colorThemeLightGray  = RGBConverter.rgb(246, green: 247, blue: 248)
        static let colorThemeMainBG     = RGBConverter.rgb(255, green: 255, blue: 255)
        static let colorTheme           = RGBConverter.rgb(78, green: 113, blue: 110)
    }
    
    // Constants.API.nameOfConstant
    struct API {
        static let  domain = "http://localhost:3000/api/v1/"
        static let  signup = domain + "signup"
        static let  lost = domain + "posts"
        static let  found = domain + "posts"
    }
    
}

