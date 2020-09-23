import UIKit

protocol HomeTopViewDelegate: class {
    func didTapLocation()
}

final class HomeTopView: UIView {
    
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentLocationButtonImage: UIImageView!
    private var locationLabelTapGestureRecognizer: UITapGestureRecognizer!
    private var locationImageTapGestureRecognizer: UITapGestureRecognizer!
    
    weak var delegate: HomeTopViewDelegate?
    
    deinit {
        currentLocationLabel.removeGestureRecognizer(locationLabelTapGestureRecognizer)
        currentLocationButtonImage.removeGestureRecognizer(locationImageTapGestureRecognizer)
    }
}

// MARK: - Configuration

extension HomeTopView {
    func configureTapRecognizer() {
        locationLabelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(locationTapped))
        locationImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(locationTapped))
        currentLocationButtonImage.addGestureRecognizer(locationLabelTapGestureRecognizer)
        currentLocationLabel.addGestureRecognizer(locationImageTapGestureRecognizer)
    }
    
    @objc private func locationTapped() {
        delegate?.didTapLocation()
    }
}
