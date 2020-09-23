import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    private var homeTopView: HomeTopView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

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
    }
    
    private func configureSubviews() {
        view.addSubview(homeTopView)
    }
    
    private func configureViews() {
        homeTopView = HomeTopView.loadFromNib()
    }
}
