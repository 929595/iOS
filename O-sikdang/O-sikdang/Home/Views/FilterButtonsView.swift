import UIKit

protocol CategoryButtonDelegate: class {
    func didTapCategoryButton()
}

protocol DistanceButtonDelegate: class {
    func didTapDistanceButton()
}

typealias FilterButtonDelegate = CategoryButtonDelegate & DistanceButtonDelegate

final class FilterButtonsView: UIView {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var categoryButton: UIView!
    @IBOutlet weak var distanceButton: UIView!
    
    weak var delegate: FilterButtonDelegate?
    
    private var categoryButtonTapGestureRecognizer: UITapGestureRecognizer!
    private var distanceButtonTapGestureRecognizer: UITapGestureRecognizer!
    
    enum Metric {
        static let cornerRadius: CGFloat = 16.0
    }
    
    override func awakeFromNib() {
        configure()
    }
    
    deinit {
        removeGestureRecognizer(categoryButtonTapGestureRecognizer)
        removeGestureRecognizer(distanceButtonTapGestureRecognizer)
    }
}

// MARK: - TapGestureRecognizer Actions

extension FilterButtonsView {
    @objc private func didTapCategoryButton() {
        delegate?.didTapCategoryButton()
    }
    
    @objc private func didTapDistanceButton() {
        delegate?.didTapDistanceButton()
    }
}

// MARK: - Configuration

extension FilterButtonsView {
    private func configureTapGestureRecognizers() {
        categoryButtonTapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapCategoryButton))
        categoryButton.addGestureRecognizer(categoryButtonTapGestureRecognizer)
        distanceButtonTapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapDistanceButton))
        distanceButton.addGestureRecognizer(distanceButtonTapGestureRecognizer)
    }
    
    private func configureViews() {
        categoryButton.round(cornerRadius: categoryButton.frame.height / 2)
        categoryButton.border(borderColor: .lightGray, borderWidth: 0.3)
        distanceButton.round(cornerRadius: distanceButton.frame.height / 2)
        distanceButton.border(borderColor: .lightGray, borderWidth: 0.3)
    }
    
    private func configure() {
        configureViews()
        configureTapGestureRecognizers()
    }
}
