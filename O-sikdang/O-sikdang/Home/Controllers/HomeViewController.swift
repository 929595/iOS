import UIKit
import SnapKit
import CoreLocation

final class HomeViewController: UIViewController {
    
    private var topView: HomeExtendableTopView!
    private var searchButton: SearchButton!
    private var locationView: CurrentLocationView!
    
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

// MARK: - CurrentLocationViewDelegate

extension HomeViewController: CurrentLocationViewDelegate {
    func didTapCurrentLocationView() {
        locationView.changeState(to: .searching)
        DispatchQueue.main.async {
            sleep(1)
            self.locationView.changeState(to: .idle)
        }
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
        locationView.snp.makeConstraints { (make) in
            make.centerX.equalTo(topView.snp.centerX)
            make.bottom.equalTo(topView.snp.bottom).offset(-32)
            make.height.equalTo(locationView.stackView.frame.height + 8)
            make.width.equalTo(locationView.stackView.frame.width + 24)
        }
    }
    
    private func configureSubViews() {
        view.addSubview(topView)
        view.addSubview(searchButton)
        view.addSubview(locationView)
    }
    
    private func configureViews() {
        view.backgroundColor = UIColor.backgroundLightGray
        topView = HomeExtendableTopView.loadFromNib()
        topView.delegate = self
        searchButton = SearchButton.loadFromNib()
        searchButton.delegate = self
        locationView = CurrentLocationView.loadFromNib()
        locationView.delegate = self
    }
    
    private func configure() {
        configureViews()
        configureSubViews()
        configureConstraints()
    }
}
