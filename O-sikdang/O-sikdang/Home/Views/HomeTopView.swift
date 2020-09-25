import UIKit
import CoreLocation

protocol currentLocationDelegate: class {
    func didTapLocation()
}

protocol filterButtonActionsDelegate: class {
    func didTapCategoryFilterButton(_ state: FilterButton.State)
    func didTapDistanceFilterButton(_ state: FilterButton.State)
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
        configureFilterButton(title: "카테고리") { [weak self] (state, filterButton) in
            self?.filterButtons
                .filter { $0 != filterButton }
                .forEach { $0.reset() }
            self?.delegate?.didTapCategoryFilterButton(state)
        }
        configureFilterButton(title: "거리") { [weak self] (state, filterButton) in
            self?.filterButtons
                .filter { $0 != filterButton }
                .forEach { $0.reset() }
            self?.delegate?.didTapDistanceFilterButton(state)
        }
    }
    
    private func configureFilterButton(
        title: String,
        stateHandler: @escaping ((FilterButton.State, UIView) -> Void)) {
            let filterButton = FilterButton.loadFromNib()
            filterButtons.append(filterButton)
            filterButton.configureTitle(title)
            filterButtonsStackView.addArrangedSubview(filterButton)
            filterButton.configureStateHandler(stateHandler)
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
