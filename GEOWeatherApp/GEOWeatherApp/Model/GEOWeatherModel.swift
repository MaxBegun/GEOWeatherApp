import Foundation
// MARK: - GeoWeatherModel
struct GeoWeatherModel: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let rain, snow: Precipitation?
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}
// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}
// MARK: - Coord
struct Coordinates: Codable {
    let lon, lat: Double
}
// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int?
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case pressure, humidity
    }
}
// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String
    let sunrise, sunset: Int
}
// MARK: - Weather
struct Weather: Codable, Hashable {
    let id: Int
    let main, weatherDescription, icon: String
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}
// MARK: - Precipitation
struct Precipitation: Codable {
    let oneHour, threeHours: Double?
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}


