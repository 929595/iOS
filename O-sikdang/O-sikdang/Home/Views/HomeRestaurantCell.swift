import UIKit

final class HomeRestaurantCell: UITableViewCell {
    
    static let identifier: String = String(describing: HomeRestaurantCell.self)

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
}

extension HomeRestaurantCell {
    private func configure() {
        configureViews()
    }
    
    private func configureViews() {
        restaurantImageView.round(cornerRadius: restaurantImageView.frame.height / 2)
    }
}
