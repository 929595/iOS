import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    private var homeTopView: HomeTopView!
    private var todayChatBubbleView: HomeTodayChatBubbleView!
    @IBOutlet weak var restaurantsTableView: UITableView!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Configuration

extension HomeViewController {
    private func configure() {
        configureViews()
        configureSubviews()
        configureViewLayouts()
    }
    
    private func configureViewLayouts() {
        homeTopView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(100)
        }
        todayChatBubbleView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(homeTopView.snp.bottom)
            make.height.equalTo(120)
        }
        restaurantsTableView.snp.makeConstraints { (make) -> Void in
            restaurantsTableView.backgroundColor = .blue
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(todayChatBubbleView.snp.bottom)
            make.height.equalTo(360)
        }
        refreshButton.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(restaurantsTableView.snp.bottom).offset(12)
            make.centerX.equalTo(restaurantsTableView.snp.centerX)
        }
    }
    
    private func configureSubviews() {
        view.addSubview(homeTopView)
        view.addSubview(todayChatBubbleView)
    }
    
    private func configureViews() {
        homeTopView = HomeTopView.loadFromNib()
        todayChatBubbleView = HomeTodayChatBubbleView.loadFromNib()
    }
}
