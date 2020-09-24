import UIKit
import SnapKit
import CoreLocation

final class HomeViewController: UIViewController {

    private var homeTopView: HomeTopView!
    private var todayChatBubbleView: HomeTodayChatBubbleView!
    @IBOutlet weak var restaurantsTableView: UITableView!
    @IBOutlet weak var refreshButton: UIButton!
    
    let locationManager = CLLocationManager()
    
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
        #warning("Handling error")
    }
}

// MARK: - HomeTopViewDelegate

extension HomeViewController: HomeTopViewDelegate {
    func didTapLocation() {
        locationManager.requestLocation()
    }
}

// MARK: - Configuration

extension HomeViewController {
    private func configure() {
        configureViews()
        configureSubviews()
        configureViewLayouts()
        configureDelegates()
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
