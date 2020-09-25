import UIKit

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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var stateHandler: ((_ currentState: State, _ at: UIView) -> Void)?
    
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
    
    func configureStateHandler(_ stateHandler: @escaping ((State, UIView) -> Void)) {
        self.stateHandler = stateHandler
    }
}

// MARK: - State

extension FilterButton {
    func reset() {
        state = .folded
    }
    
    private func flipState() {
        state = state == .folded ? .unfolded : .folded
    }
    
    private func folded() {
        guard state == .folded else { return }
        imageView.image = UIImage(systemName: "chevron.down")
        backgroundColor = .white
    }
    
    private func unfolded() {
        guard state == .unfolded else { return }
        imageView.image = UIImage(systemName: "chevron.up")
        backgroundColor = UIColor(white: 0.8, alpha: 1)
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
        stateHandler?(state, self)
        flipState()
    }
}
