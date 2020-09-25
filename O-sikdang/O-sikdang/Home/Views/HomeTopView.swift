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
    
    private var filterButtons: [FilterButton] = []
    
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
        configureFilterButton(title: "카테고리") { [weak self] in
            self?.delegate?.didTapCategoryFilterButton()
        }
        configureFilterButton(title: "거리") { [weak self] in
            self?.delegate?.didTapDistanceFilterButton()
        }
    }
    
    private func configureFilterButton(title: String, delegateAction: @escaping (() -> Void)) {
        let filterButton = FilterButton.loadFromNib()
        filterButtons.append(filterButton)
        filterButton.configureTitle(title)
        filterButtonsStackView.addArrangedSubview(filterButton)
        filterButton.addAction(delegateAction)
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
