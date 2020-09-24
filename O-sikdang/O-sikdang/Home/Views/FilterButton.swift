import UIKit

final class FilterButton: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var action: (() -> Void)?
    
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
    
    func addAction(_ action: @escaping (() -> Void)) {
        self.action = action
    }
}

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
        action?()
    }
}
