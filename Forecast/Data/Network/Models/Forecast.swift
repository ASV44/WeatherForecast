class Forecast: Codable {
    var weather: [Weather]
    var indexes: WeatherIndex
    var windIndex: WindIndex
    var specification: Specification
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case indexes = "main"
        case windIndex = "wind"
        case specification = "sys"
        case name
    }
}
