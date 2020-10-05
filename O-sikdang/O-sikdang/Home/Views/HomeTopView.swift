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
    
    private enum FilterTitle {
        static let Category = "카테고리"
        static let Distance = "거리"
    }
    
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

extension HomeTopView: FilterButtonDelegate {
    func didTapFilterButton(_ filterButton: FilterButton) {
        let count = filterButtons.filter({$0.state != .folded}).count
        guard count == 0 else {
            filterButtons.forEach { $0.fold() }
            return
        }
        filterButton.unfold()
        switch filterButton.title {
        case FilterTitle.Category:
            delegate?.didTapCategoryFilterButton(.unfolded)
        case FilterTitle.Distance:
            delegate?.didTapDistanceFilterButton(.unfolded)
        default:
            break
        }
    }
}

extension HomeTopView {
    private func configureFilterButtons() {
        configureFilterButton(title: FilterTitle.Category)
        configureFilterButton(title: FilterTitle.Distance)
    }
    
    private func configureFilterButton(title: String) {
            let filterButton = FilterButton.loadFromNib()
            filterButtons.append(filterButton)
            filterButton.delegate = self
            filterButton.configureTitle(title)
            filterButtonsStackView.addArrangedSubview(filterButton)
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
