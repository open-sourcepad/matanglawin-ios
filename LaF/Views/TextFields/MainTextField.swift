import UIKit

class MainTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0.1, alpha: 0.3)
        self.textColor = Constants.Colors.colorFontTitle
        self.font = UIFont.systemFontOfSize(20.0)

        let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.frame.height))
        self.leftView = paddingView
        
        self.leftViewMode = UITextFieldViewMode.Always

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isetPlaceholder(str: String){
        self.attributedPlaceholder = NSAttributedString(string:str,
            attributes:[NSForegroundColorAttributeName: Constants.Colors.colorFontReg])
    }
}