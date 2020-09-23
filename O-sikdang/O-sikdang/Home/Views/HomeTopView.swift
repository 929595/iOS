import UIKit

protocol HomeTopViewDelegate: class {
    func didTapLocation()
}

final class HomeTopView: UIView {
    
    @IBOutlet weak var currentLocationStackView: UIStackView! {
        didSet {
            currentLocationTapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(locationTapped))
            currentLocationStackView.addGestureRecognizer(currentLocationTapGestureRecognizer)
        }
    }
    @IBOutlet weak var currentLocationLabel: UILabel!
    private var currentLocationTapGestureRecognizer: UITapGestureRecognizer!
    
    weak var delegate: HomeTopViewDelegate?
    
    deinit {
        currentLocationStackView.removeGestureRecognizer(currentLocationTapGestureRecognizer)
    }
    
    @objc private func locationTapped() {
        delegate?.didTapLocation()
    }
}
