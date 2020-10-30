import UIKit

protocol HomeExtendableTopViewDelegate: class {
    func didChangeState(to state: HomeExtendableTopView.State)
}

final class HomeExtendableTopView: UIView {
    
    enum State {
        case idle
        case searching
        case complete
    }
    
    enum Metric {
        static let cornerRadius: CGFloat = 36
    }
    
    private(set) var state: State = .idle {
        didSet {
            delegate?.didChangeState(to: state)
        }
    }
    weak var delegate: HomeExtendableTopViewDelegate?
    
    override func awakeFromNib() {
        configure()
    }
    
    func changeState(to state: State) {
        self.state = state
    }
}

// MARK: - Configuration

extension HomeExtendableTopView {
    private func configure() {
        configureViews()
    }
    
    private func configureViews() {
        layer.masksToBounds = true
        layer.cornerRadius = Metric.cornerRadius
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}
