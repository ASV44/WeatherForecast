final class ForecastInteractor: BaseInteractor<ForecastView> {
    private var apiService: APIService
    var cellModels: [String: [ForecastCellModel]] = [:]
    var sections: [String] = []
    
    init(apiService: APIService) {
        self.apiService = apiService
        super.init()
    }
    
    func fetchCurrentWeatherForecast(for city: String) {
        apiService.getCurrentWeather(for: city)
            .onSuccess { [weak self] forecast in
                self?.processResponse(for: forecast)
                self?.view.reloadData()
            }.onFailure { [weak self] error in
                self?.onError(error: error)
            }.run().disposed(by: disposeBag)
    }
    
    private func processResponse(for forecast: Forecast) {
        var regionForecasts = cellModels[forecast.specification.country] ?? []
        regionForecasts.removeAll { $0.city == forecast.name }
        regionForecasts.insert(ForecastCellModel(from: forecast), at: 0)
        cellModels[forecast.specification.country] = regionForecasts
        sections.removeAll { $0 == forecast.specification.country }
        sections.insert(forecast.specification.country, at: 0)
    }
}
