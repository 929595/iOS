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
        static let topViewBottomPaddingNormal: CGFloat = -100
        static let topViewExtendedHeightRatio: CGFloat = 0.3
        static let searchButtonTopMargin: CGFloat = 48
        static let searchButtonWidthRatio: CGFloat = 0.6
        static let searchButtonHeightRatio: CGFloat = 0.6 * 0.26
        static let searchButtonTopPadding: CGFloat = 100
        static let filterButtonsViewBottomMargin: CGFloat = 24.0
        static let locationViewBottomMargin: CGFloat = 20.0
        static let locationViewWidthRatio: CGFloat = 0.8
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
        self.locationView.changeState(to: .searching)
        let time = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.self.locationView.changeState(to: .idle)
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
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.leading.equalToSuperview().offset(-Metric.topViewSideOffset)
            make.trailing.equalToSuperview().offset(Metric.topViewSideOffset)
            make.bottom.equalTo(searchButton.snp.top).offset(Metric.topViewBottomPaddingNormal)
        }
        
        searchButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(topView.snp.centerX)
            make.top.equalTo(view.snp.centerY).offset(Metric.searchButtonTopPadding)
            make.width.equalTo(view.frame.width * Metric.searchButtonWidthRatio)
            make.height.equalTo(view.frame.width * Metric.searchButtonHeightRatio)
        }
        
        locationView.snp.makeConstraints { (make) in
            make.centerX.equalTo(topView.snp.centerX)
            make.bottom.equalTo(filterButtonsView.snp.top).offset(-Metric.locationViewBottomMargin)
            make.height.equalTo(locationView.frame.height)
            make.width.equalTo(view.frame.width * Metric.locationViewWidthRatio)
        }
        
        filterButtonsView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(topView.snp.bottom).offset(-Metric.filterButtonsViewBottomMargin)
            make.height.equalTo(filterButtonsView.stackView.frame.height)
            make.width.equalTo(locationView.stackView.frame.width)
        }
        view.layoutIfNeeded()
        searchButton.round(cornerRadius: searchButton.frame.height / 2)
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
