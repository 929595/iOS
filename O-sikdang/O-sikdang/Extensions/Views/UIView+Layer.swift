import UIKit

extension UIView {
    func round(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
    
    func border(borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
}
