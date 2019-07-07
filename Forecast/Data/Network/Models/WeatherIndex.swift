final class WeatherIndex: Codable {
    var temperature: Double
    var pressure: Double
    var humidity: Double
    var temperatureMax: Double
    var temperatureMin: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure
        case humidity
        case temperatureMax = "temp_max"
        case temperatureMin = "temp_min"
    }
}

final class WindIndex: Codable {
    var speed: Double
    var degree: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}
