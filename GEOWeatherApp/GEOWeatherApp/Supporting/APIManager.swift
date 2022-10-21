import Alamofire
final class APIManager {
    static let instance = APIManager()
    private let keyAPI = "8b59fef97ddf9fe3bf13ad7d6679ba2c"
    enum Constant {
        static let baseURL = "https://api.openweathermap.org/data/2.5"
    }
    enum EndPoints {
        static let weather = "/weather?"
    }
    enum Metric {
        static let metric = "&units=metric"
        static let standard = "&units=standard"
        static let imperial = "&units=imperial"
    }
    // func for building url using requirements
    private func setupAPI(BaseURL: String,
                          EndPoint: String,
                          lat: Double,
                          lon: Double,
                          units: String) -> String {
        let url = "\(BaseURL)\(EndPoint)lat=\(lat)&lon=\(lon)\(units)&appid=\(keyAPI)"
        return url
    }
    func getUsersData(latitude lat: Double,
                      longitude long: Double,
                      completion: @escaping ((GeoWeatherModel) -> Void)) {
        AF.request(setupAPI(BaseURL: Constant.baseURL,
                            EndPoint: EndPoints.weather,
                            lat: lat,
                            lon: long,
                            units: Metric.metric
                           )
        ).responseDecodable(of: GeoWeatherModel.self ) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    private init() { }
}
