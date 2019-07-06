final class ForecastCellModel {
    var city: String
    var temperature: Double
    var humidity: Double
    var windSpeed: Double
    var description: String
    var descriptionDetails: String
    
    init(city: String,
         temperature: Double,
         humidity: Double,
         windSpeed: Double,
         description: String,
         descriptionDetails: String) {
        self.city = city
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.description = description
        self.descriptionDetails = descriptionDetails
    }
    
    init(from forecast: Forecast) {
        self.city = forecast.name
        self.temperature = forecast.indexes.temperature - 273
        self.humidity = forecast.indexes.humidity
        self.windSpeed = forecast.windIndex.speed
        self.description = forecast.weather.first?.main ?? ""
        self.descriptionDetails = forecast.weather.first?.description ?? ""
    }
}
