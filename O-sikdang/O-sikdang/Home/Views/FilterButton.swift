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
    
    private func configure() {
        round(cornerRadius: 18)
    }
    
    func configureText() {
        var randomTitle: String = ""
        for _ in 0..<Int.random(in: 1...5) {
            randomTitle += "헤"
        }
        titleLabel.text = randomTitle
    }
}
