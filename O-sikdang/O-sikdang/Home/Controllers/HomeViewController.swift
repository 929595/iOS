import UIKit
import SnapKit
import CoreLocation

final class HomeViewController: UIViewController {

    private var homeTopView: HomeTopView!
    private var todayChatBubbleView: HomeTodayChatBubbleView!
    private var restaurantsTableView = UITableView()
    private var refreshButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    private enum Metric {
        static let topViewHeight: CGFloat = 88.0
        static let chatBubbleViewHeight: CGFloat = 120.0
        static let refreshButtonTopMargin: CGFloat = 12.0
        static let refreshButtonFontSize: CGFloat = 14.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - Core Location

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let coordinate = location.coordinate
            homeTopView.updateCurrentLocation(coordinate: coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alertController = UIAlertController(title: "위치 정보 오류",
                                                message: "위치 정보를 불러올 수 없습니다.",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - HomeTopViewDelegate

extension HomeViewController: HomeTopViewDelegate {
    func didTapDistanceFilterButton(_ state: FilterButton.State) {
        #warning("Distance filter tapped")
    }
    
    func didTapCategoryFilterButton(_ state: FilterButton.State) {
        #warning("Category filter tapped")
    }
    
    func didTapLocation() {
        locationManager.requestLocation()
    }
}

// MARK: - TableViewDelegates

extension HomeViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeRestaurantCell.identifier,
            for: indexPath)
        return cell
    }
}

// MARK: - Configuration

extension HomeViewController {
    private func configure() {
        configureViews()
        configureSubviews()
        configureViewLayouts()
        configureDelegates()
        configureTableView()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: HomeRestaurantCell.identifier, bundle: nil)
        restaurantsTableView.allowsSelection = false
        restaurantsTableView.isScrollEnabled = false
        restaurantsTableView.register(
            nib,
            forCellReuseIdentifier: HomeRestaurantCell.identifier)
        restaurantsTableView.dataSource = self
        self.view.layoutIfNeeded()
        restaurantsTableView.snp.makeConstraints { (make) in
            make.height.equalTo(restaurantsTableView.contentSize.height)
        }
    }
    
    private func configureDelegates() {
        homeTopView.delegate = self
        locationManager.delegate = self
    }
    
    private func configureViewLayouts() {
        homeTopView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(Metric.topViewHeight)
        }
        restaurantsTableView.snp.makeConstraints { (make) -> Void in
            restaurantsTableView.backgroundColor = .blue
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(homeTopView.snp.bottom)
            make.height.equalTo(view.frame.height)
        }
        refreshButton.snp.updateConstraints { (make) -> Void in
            make.top.equalTo(restaurantsTableView.snp.bottom).offset(Metric.refreshButtonTopMargin)
            make.centerX.equalTo(restaurantsTableView.snp.centerX)
        }
    }
    
    private func configureRefreshButton() {
        refreshButton = UIButton(type: .system)
        refreshButton.setTitle("다시 추천하기", for: .normal)
        refreshButton.setTitleColor(.black, for: .normal)
        refreshButton.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    private func configureSubviews() {
        configureRefreshButton()
        view.addSubview(homeTopView)
        view.addSubview(todayChatBubbleView)
        view.addSubview(restaurantsTableView)
        view.addSubview(refreshButton)
    }
    
    private func configureViews() {
        homeTopView = HomeTopView.loadFromNib()
        todayChatBubbleView = HomeTodayChatBubbleView.loadFromNib()
    }
}
