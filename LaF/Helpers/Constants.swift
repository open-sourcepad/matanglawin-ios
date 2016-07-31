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
        static let colorThemeMainBG     = RGBConverter.rgb(37, green: 43, blue: 50)
        static let colorTheme           = RGBConverter.rgb(37, green: 43, blue: 50)
        static let colorFontReg         = RGBConverter.rgb(160, green: 164, blue: 167)
        static let colorFontTitle       = RGBConverter.rgb(255, green: 255, blue: 255)
        
    }
    
    // Constants.API.nameOfConstant
    struct API {
        static let  domain = "https://finder-sp.herokuapp.com/api/" //"http://87d4b8e6.ngrok.io/api/"
        static let  signup = domain + "oauth"
        static let  lost = domain + "search/lost"
        static let  found = domain + "search/found"
        static let  create_post = domain + "listings"
    }
    
}

