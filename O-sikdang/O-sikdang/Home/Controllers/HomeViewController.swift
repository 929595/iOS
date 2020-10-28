import UIKit
import SnapKit
import CoreLocation

final class HomeViewController: UIViewController {
    
    private var topView: HomeExtendableTopView!
    private var searchButton: SearchButton!
    private var locationView: CurrentLocationView!
    private var filterButtonsView: FilterButtonsView!
    
    enum Metric {
        static let topViewSideOffset: CGFloat = 4
        static let topViewNormalHeight: CGFloat = 160
        static let topViewExtendedHeightRatio: CGFloat = 0.7
        static let searchButtonTopMargin: CGFloat = 24
        static let filterButtonsViewBottmMargin: CGFloat = 20
        static let filterButtonsViewSideMargin: CGFloat = 24
        static let locationViewBottomMargin: CGFloat = 24.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - FilterButtonsViewDelegate

extension HomeViewController: FilterButtonDelegate {
    func didTapCategoryButton() {
        #warning("category filter button action")
    }
    
    func didTapDistanceButton() {
        #warning("distance filter button action")
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
        filterButtonsView.snp.makeConstraints { (make) in
            make.centerX.equalTo(topView.snp.centerX)
            make.bottom.equalTo(topView.snp.bottom).offset(-Metric.filterButtonsViewBottmMargin)
            make.height.equalTo(filterButtonsView.stackView.frame.height)
            make.width.equalTo(view.frame.width - Metric.filterButtonsViewSideMargin * 2)
        }
        locationView.snp.makeConstraints { (make) in
            make.centerX.equalTo(topView.snp.centerX)
            make.bottom.equalTo(filterButtonsView.snp.top).offset(-Metric.locationViewBottomMargin)
            make.height.equalTo(locationView.stackView.frame.height + 8)
            make.width.equalTo(locationView.stackView.frame.width + 24)
        }
        
    }
    
    private func configureSubViews() {
        view.addSubview(topView)
        view.addSubview(searchButton)
        view.addSubview(locationView)
        view.addSubview(filterButtonsView)
    }
    
    private func configureViews() {
        view.backgroundColor = UIColor.backgroundLightGray
        topView = HomeExtendableTopView.loadFromNib()
        topView.delegate = self
        searchButton = SearchButton.loadFromNib()
        searchButton.delegate = self
        locationView = CurrentLocationView.loadFromNib()
        locationView.delegate = self
        filterButtonsView = FilterButtonsView.loadFromNib()
        filterButtonsView.delegate = self
    }
    
    private func configure() {
        configureViews()
        configureSubViews()
        configureConstraints()
    }
}
