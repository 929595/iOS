import UIKit
import CoreLocation

protocol HomeTopViewDelegate: class {
    func didTapLocation()
    func didTapCategoryFilterButton()
}

final class HomeTopView: UIView {
    
    @IBOutlet weak var currentLocationStackView: UIStackView!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var filterButtonsStackView: UIStackView!
    
    private var categoryFilterButton: FilterButton!
    
    private var currentLocationTapGestureRecognizer: UITapGestureRecognizer!
    
    weak var delegate: HomeTopViewDelegate?
    
    deinit {
        currentLocationStackView.removeGestureRecognizer(currentLocationTapGestureRecognizer)
    }
    
    override func awakeFromNib() {
        configure()
    }
    
    func updateCurrentLocation(coordinate: CLLocationCoordinate2D) {
        currentLocationLabel.text = "(\(coordinate.latitude), \(coordinate.longitude))"
    }
    
    @objc private func locationTapped() {
        delegate?.didTapLocation()
    }
}

extension HomeTopView {
    private func configureFilterButtons() {
        categoryFilterButton = FilterButton.loadFromNib()
        filterButtonsStackView.addArrangedSubview(categoryFilterButton)
        categoryFilterButton.configureTitle("카테고리")
        categoryFilterButton.addAction { [weak self] in
            self?.delegate?.didTapCategoryFilterButton()
        }
    }
    
    private func configureTapGestureRecognizer() {
        currentLocationTapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(locationTapped))
        currentLocationStackView.addGestureRecognizer(currentLocationTapGestureRecognizer)
    }
    
    private func configure() {
        configureTapGestureRecognizer()
        configureFilterButtons()
    }
}
