import UIKit

class TemplateViewController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Constants.Colors.colorThemeMainBG
        
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBarHidden = false
        self.navigationController!.navigationBar.barTintColor = Constants.Colors.colorTheme
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Constants.Colors.colorThemeLightGray]


        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icon-camera"),
            style: UIBarButtonItemStyle.Plain ,
            target: self, action: "cameraAction")
        rightBarButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

//        let burger = UIButton()
//        burger.setTitle("Burger", forState: .Normal)
//        burger.frame = CGRectMake(0, 0, 80, 50)
//        burger.addTarget(self, action: Selector("burgerAction"), forControlEvents: .TouchUpInside)
//        
//        //.... Set Right/Left Bar Button item
//        let leftBarButton = UIBarButtonItem()
//        leftBarButton.customView = burger
//        self.navigationItem.leftBarButtonItem = leftBarButton
    }

    func burgerAction() {
        print("soon...")
    }
    
    func cameraAction(){
        self.appDelegate.window?.rootViewController = self.appDelegate.mainNavigation
    }
}