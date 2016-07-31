import UIKit

class MainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.Colors.colorFontReg
        self.layer.cornerRadius = 15.0
        self.setTitleColor(Constants.Colors.colorFontTitle, forState: .Normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}