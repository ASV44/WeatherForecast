import Foundation

final class ForecastInteractor: BaseInteractor<ForecastView> {
    private var apiService: APIService
    private var cityListing: CityListing!
    var cellModels: [String: [ForecastCellModel]] = [:]
    var sections: [String] = []
    
    init(apiService: APIService) {
        self.apiService = apiService
        super.init()
    }
    
    func viewDidLoad() {
        restoreCachedCities()
        cityListing.cities.forEach { fetchCurrentWeatherForecast(for: $0.name) }
    }
    
    private func restoreCachedCities() {
        cityListing = CityListing().restore()
        if cityListing.cities.isEmpty {
            cityListing.add(cities: restoreDefaultCities())
        }
    }
    
    func fetchCurrentWeatherForecast(for city: String) {
        guard !city.isEmpty else { return }
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
        cityListing.add(city: forecast.name, cod: forecast.specification.country)
    }
    
    func restoreDefaultCities() -> [City] {
        guard let filePath = Bundle.main.url(forResource: "cities", withExtension: "json"),
            let data = try? Data(contentsOf: filePath, options: .alwaysMapped),
            let instance = try? JSONDecoder().decode([City].self, from: data) else { return [] }
        return instance
    }
    
    func viewWillTerminate() {
        cacheAvailableCities()
    }
    
    private func cacheAvailableCities() {
        cityListing.persist()
    }
}
