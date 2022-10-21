import MapKit

final class MapViewController: UIViewController {
    // MARK: - Privates
    private let tapRecognizer = UITapGestureRecognizer()
    private let map = MKMapView()
    private let locationManager = CLLocationManager()
    private let findMeButton = UIButton()
    private let getWeatherButton = UIButton()
    private let cityTempLabel = CityTempLabel()
    private var geoDataArray: GeoWeatherModel?
    // MARK: - Lifecycle
    override func loadView() {
        view = map
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupUI()
        addConstraints()
    }
    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(findMeButton)
        view.addSubview(getWeatherButton)
        view.addGestureRecognizer(tapRecognizer)
        view.addSubview(cityTempLabel)
    }
    private func setupUI() {
        // map
        map.showsUserLocation = true
        // locationManager
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopUpdatingHeading()
        // tapRecognizer
        tapRecognizer.addTarget(self,
                                action: #selector(touchedScreen(touch:)))
        // findMeButton
        findMeButton.setImage(imageConfigForFindMeButton(),
                              for: .normal)
        findMeButton.addTarget(self,
                               action: #selector(findMeDidTapped),
                               for: .touchUpInside)
        // getWeatherButton
        getWeatherButton.setImage(imageConfigForGetWeatherButton(), for: .normal)
        getWeatherButton.addTarget(self,
                                   action: #selector(getWeatherButtonDidTapped),
                                   for: .touchUpInside)
    }
    private func addConstraints() {
        // findMeButton Constraints
        findMeButton.translatesAutoresizingMaskIntoConstraints = false
        findMeButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 50).isActive = true
        findMeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        findMeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        findMeButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // getWeatherButton Constraints
        getWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        getWeatherButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -50).isActive = true
        getWeatherButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        getWeatherButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        getWeatherButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // cityTempLabel Constraints
        cityTempLabel.translatesAutoresizingMaskIntoConstraints = false
        cityTempLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        cityTempLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        cityTempLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        cityTempLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    // MARK: - Actions
    // action for findMeButton
    @objc private func findMeDidTapped() {
        if let point = locationManager.location?.coordinate {
            let location = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            map.setRegion(region, animated: true)
        }
    }
    // action for getWeatherButton
    @objc private func getWeatherButtonDidTapped() {
        if let point = locationManager.location?.coordinate {
            APIManager.instance.getUsersData(latitude: point.latitude, longitude: point.longitude) { data in
                self.cityTempLabel.text = "\(data.name): \(data.main.temp)℃"
            }
        }
    }
    // action that takes lon/lat when touch the screen
    @objc func touchedScreen(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.map)
        let touchMapCoordinate = map.convert(touchPoint, toCoordinateFrom: map)
        APIManager.instance.getUsersData(latitude: touchMapCoordinate.latitude,
                                         longitude: touchMapCoordinate.longitude) { data in
            self.cityTempLabel.text = "\(data.name): \(data.main.temp)℃"
        }
    }
    // MARK: - Helpers
    // setup image for findMeButton
    private func imageConfigForFindMeButton() -> UIImage? {
        let configurator = UIImage.SymbolConfiguration(
            pointSize: 40,
            weight: .bold,
            scale: .large
        )
        let imageForFindMeButton = UIImage(systemName: "location.circle.fill",
                                           withConfiguration: configurator
        )
        return imageForFindMeButton
    }
    // setup image for getWeatherButton
    private func imageConfigForGetWeatherButton() -> UIImage? {
        let configurator = UIImage.SymbolConfiguration(
            pointSize: 40,
            weight: .bold,
            scale: .large
        )
        let imageForFindMeButton = UIImage(systemName: "cloud.sun.rain.fill",
                                           withConfiguration: configurator)
        return imageForFindMeButton
    }
}
