import UIKit

extension UIView {
    static func animateWithDamping(
        withDuration: TimeInterval,
        delay: TimeInterval = 0.0,
        options: AnimationOptions = .curveEaseOut,
        animations: @escaping (() -> Void),
        completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: withDuration,
            delay: delay,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: options,
            animations: animations,
            completion: completion)
    }
}
