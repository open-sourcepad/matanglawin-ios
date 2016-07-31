import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var currentUser: UserDM = UserDM();
    
    lazy var finderViewController: FinderViewController = {
        var ctrl = FinderViewController()
        return ctrl
    }()

    lazy var mainNavigation: UINavigationController = {
        var ctrl = UINavigationController()
        ctrl.title = "Feeds"
        return ctrl
    }()

    lazy var postsViewController: PostsViewController = {
        var ctrl = PostsViewController()
        return ctrl
    }()
    
    lazy var postNavigation: UINavigationController = {
        var ctrl = UINavigationController()
        ctrl.title = "Feeds"
        return ctrl
    }()

    lazy var facebookController: FacebookViewController = {
        var ctrl = FacebookViewController()
        ctrl.title = "Auth"
        return ctrl
    }()


    lazy var authNavigation: UINavigationController = {
        var ctrl = UINavigationController()
        ctrl.title = "Auth"
        return ctrl
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        mainNavigation.viewControllers    = [finderViewController]
        authNavigation.viewControllers    = [facebookController]
        postNavigation.viewControllers    = [postsViewController]

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        if let window = window {
            if (NSUserDefaults.standardUserDefaults().objectForKey("defaults saved user") == nil) {
                window.rootViewController = authNavigation
            }else{
                self.currentUser = UserDM.getActiveUser()
                window.rootViewController = mainNavigation //postNavigation
            }

            window.makeKeyAndVisible()
        }

        return true
    }

    func application(application: UIApplication,openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application,
            openURL: url,
            sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String,
            annotation: options [UIApplicationOpenURLOptionsAnnotationKey])
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

}