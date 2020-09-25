import UIKit
import CoreLocation

protocol currentLocationDelegate: class {
    func didTapLocation()
}

protocol filterButtonActionsDelegate: class {
    func didTapCategoryFilterButton()
    func didTapDistanceFilterButton()
}

typealias HomeTopViewDelegate = currentLocationDelegate & filterButtonActionsDelegate

final class HomeTopView: UIView {
    
    @IBOutlet weak var currentLocationStackView: UIStackView!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var filterButtonsStackView: UIStackView!
    
    private var categoryFilterButton: FilterButton!
    private var distanceFilterButton: FilterButton!
    
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
        configureCategoryFilterButton()
        configureDistanceFilterButton()
    }
    
    private func configureCategoryFilterButton() {
        categoryFilterButton = FilterButton.loadFromNib()
        filterButtonsStackView.addArrangedSubview(categoryFilterButton)
        categoryFilterButton.configureTitle("카테고리")
        categoryFilterButton.addAction { [weak self] in
            self?.delegate?.didTapCategoryFilterButton()
        }
    }
    
    private func configureDistanceFilterButton() {
        distanceFilterButton = FilterButton.loadFromNib()
        filterButtonsStackView.addArrangedSubview(distanceFilterButton)
        distanceFilterButton.configureTitle("거리")
        distanceFilterButton.addAction { [weak self] in
            self?.delegate?.didTapDistanceFilterButton()
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
