import UIKit

protocol FilterButtonDelegate: class {
    func didTapFilterButton(_ filterButton: FilterButton)
}

final class FilterButton: UIView {
    
    enum State {
        case folded
        case unfolded
    }
    
    private(set) var state: State = .folded {
        didSet {
            switch state {
            case .folded:
                folded()
            case .unfolded:
                unfolded()
            }
        }
    }
    
    weak var delegate: FilterButtonDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var title: String {
        return titleLabel.text!
    }
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    deinit {
        removeGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureTitle(_ title: String) {
        titleLabel.text = title
    }
}

// MARK: - State

extension FilterButton {
    func fold() {
        state = .folded
    }
    
    func unfold() {
        state = .unfolded
    }
    
    private func folded() {
        UIView.animate(withDuration: 0.3) {
            self.imageView.image = UIImage(systemName: "chevron.down")
            self.backgroundColor = .white
        }
    }
    
    private func unfolded() {
        UIView.animate(withDuration: 0.3) {
            self.imageView.image = UIImage(systemName: "chevron.up")
            self.backgroundColor = UIColor(white: 0.8, alpha: 1)
        }
    }
}

// MARK: - Configuration

extension FilterButton {
    private func configure() {
        round(cornerRadius: 18)
        configureTapGestureRecognizer()
    }
    
    private func configureTapGestureRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                      action: #selector(filterButtonDidTap))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func filterButtonDidTap() {
        delegate?.didTapFilterButton(self)
    }
}
