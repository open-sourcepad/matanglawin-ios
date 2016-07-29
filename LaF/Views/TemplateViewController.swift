import UIKit

class TemplateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Constants.Colors.colorThemeMainBG
        
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBarHidden = false
        self.navigationController!.navigationBar.barTintColor = Constants.Colors.colorTheme
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Constants.Colors.colorThemeLightGray]

        let camera = UIButton()
        camera.setTitle("Camera", forState: .Normal)
        camera.frame = CGRectMake(0, 0, 80, 50)
        camera.addTarget(self, action: Selector("action"), forControlEvents: .TouchUpInside)

        //.... Set Right/Left Bar Button item
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = camera
        self.navigationItem.rightBarButtonItem = rightBarButton

        let burger = UIButton()
        burger.setTitle("Burger", forState: .Normal)
        burger.frame = CGRectMake(0, 0, 80, 50)
        burger.addTarget(self, action: Selector("action"), forControlEvents: .TouchUpInside)
        
        //.... Set Right/Left Bar Button item
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = burger
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
}