import UIKit

final class FilterButton: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureTitle(_ title: String) {
        titleLabel.text = title
    }
}

extension FilterButton {
    private func configure() {
        round(cornerRadius: 18)
    }
}
