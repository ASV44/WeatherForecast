final class ForecastCellModel {
    var city: String
    var temperature: String
    var humidity: Double
    var windSpeed: Double
    var description: String
    
    init(city: String, temperature: String, humidity: Double, windSpeed: Double, description: String) {
        self.city = city
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.description = description
    }
}
