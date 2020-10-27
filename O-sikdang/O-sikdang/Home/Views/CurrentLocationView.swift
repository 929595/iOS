import UIKit

protocol CurrentLocationViewDelegate: class {
    func didTapCurrentLocationView()
}

final class CurrentLocationView: UIView {
    
    enum State {
        case idle
        case searching
    }

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    private var gestureRecognizer: UITapGestureRecognizer!
    
    weak var delegate: CurrentLocationViewDelegate?
    
    private var state: State = .idle {
        didSet {
            switch state {
            case .idle:
                animateToIdle()
            case .searching:
                animateToSearching()
            }
        }
    }
    
    override func awakeFromNib() {
        configure()
    }
    
    deinit {
        removeGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func didTapCurrentLocationView() {
        guard state == .idle else {
            return
        }
        delegate?.didTapCurrentLocationView()
    }
    
    func changeState(to state: State) {
        self.state = state
    }
}

// MARK: - Animation

extension CurrentLocationView {
    private func animateToIdle() {
        UIView.animateWithDamping(withDuration: 0.5) {
            self.stackView.alpha = 1.0
            self.activityIndicatorView.alpha = 0.0
        } completion: { _ in
            self.stackView.isHidden = false
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
        }
    }
    
    private func animateToSearching() {
        activityIndicatorView.isHidden = false
        UIView.animateWithDamping(withDuration: 0.5) {
            self.stackView.alpha = 0.0
            self.activityIndicatorView.alpha = 1.0
            self.activityIndicatorView.startAnimating()
        } completion: { _ in
            self.stackView.isHidden = true
        }
    }
}

// MARK: - Configuration

extension CurrentLocationView {
    private func configureTapGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapCurrentLocationView))
        addGestureRecognizer(gestureRecognizer)
    }
    
    private func configure() {
        configureTapGestureRecognizer()
    }
}
