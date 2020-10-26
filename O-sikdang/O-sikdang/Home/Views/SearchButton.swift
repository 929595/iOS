import UIKit

protocol SearchButtonDelegate: class {
    func didTapSearchButton()
}

final class SearchButton: UIView {
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    weak var delegate: SearchButtonDelegate?
    
    enum State {
        case idle
        case searching
        case complete
    }
    
    enum Metric {
        static let width: CGFloat = 88.0
        static let height: CGFloat = 88.0
    }
    
    private var state: State = .idle {
        didSet {
            switch state {
            case .idle:
                animateIdle()
            case .searching:
                break
            case .complete:
                shrink()
            }
        }
    }
    
    override func awakeFromNib() {
        configure()
    }
    
    deinit {
        removeGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleSearchTap() {
        guard state != .searching else {
            return
        }
        delegate?.didTapSearchButton()
    }
    
    func changeState(to state: State) {
        self.state = state
    }
}

// MARK: - Animation

extension SearchButton {
    private func animateIdle() {
        UIView.animateWithDamping(withDuration: 1) {
            self.transform = .identity
            self.alpha = 1.0
        }
    }
    
    private func shrink() {
        UIView.animateWithDamping(withDuration: 1) {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.alpha = 0.0
        }
    }
}

// MARK: - Configuration

extension SearchButton {
    private func configureTapGestureRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSearchTap))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configureViews() {
        round(cornerRadius: Metric.width / 2)
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .init(width: 0, height: 0)
        layer.shadowRadius = 4.0
    }
    
    private func configure() {
        configureViews()
        configureTapGestureRecognizer()
    }
}
