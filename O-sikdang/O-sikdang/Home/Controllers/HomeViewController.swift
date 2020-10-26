import UIKit
import SnapKit
import CoreLocation

final class HomeViewController: UIViewController {
    
    private var topView: HomeExtendableTopView!
    private var searchButton: SearchButton!
    
    enum Metric {
        static let topViewSideOffset: CGFloat = 4
        static let topViewNormalHeight: CGFloat = 160
        static let topViewExtendedHeightRatio: CGFloat = 0.7
        static let searchButtonTopMargin: CGFloat = 24
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - SearchButtonDelegate

extension HomeViewController: SearchButtonDelegate {
    func didTapSearchButton() {
        if topView.state == .idle {
            searchButton.changeState(to: .searching)
        }
    }
}

// MARK: - HomeExtendableTopViewDelegate

extension HomeViewController: HomeExtendableTopViewDelegate {
    func didChangeState(to state: HomeExtendableTopView.State) {
        if state == .complete {
            configureTopViewConstraints(height: Metric.topViewNormalHeight)
        } else if state == .idle {
            configureTopViewConstraints(height: view.frame.height * Metric.topViewExtendedHeightRatio)
        }
        UIView.animateWithDamping(withDuration: 0.7) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Configuration

extension HomeViewController {
    private func configureTopViewConstraints(height: CGFloat) {
        topView.snp.remakeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.leading.equalToSuperview().offset(-Metric.topViewSideOffset)
            make.trailing.equalToSuperview().offset(Metric.topViewSideOffset)
            make.height.equalTo(height)
        }
    }
    
    private func configureConstraints() {
        configureTopViewConstraints(height: view.frame.height * Metric.topViewExtendedHeightRatio)
        searchButton.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(Metric.searchButtonTopMargin)
            make.centerX.equalTo(topView.snp.centerX)
            make.width.equalTo(SearchButton.Metric.width)
            make.height.equalTo(SearchButton.Metric.height)
        }
    }
    
    private func configureSubViews() {
        view.addSubview(topView)
        view.addSubview(searchButton)
    }
    
    private func configureViews() {
        view.backgroundColor = UIColor.backgroundLightGray
        topView = HomeExtendableTopView.loadFromNib()
        topView.delegate = self
        searchButton = SearchButton.loadFromNib()
        searchButton.delegate = self
    }
    
    private func configure() {
        configureViews()
        configureSubViews()
        configureConstraints()
    }
}
