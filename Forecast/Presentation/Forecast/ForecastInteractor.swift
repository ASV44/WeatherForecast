final class ForecastInteractor: BaseInteractor<ForecastView> {
    private var apiService: APIService
    var cellModels: [ForecastCellModel] = []
    
    init(apiService: APIService) {
        self.apiService = apiService
        super.init()
    }
    
    func fetchCurrentWeatherForecast(for city: String) {
        apiService.getCurrentWeather(for: city)
            .onSuccess { [weak self] forecast in
                self?.cellModels.append(ForecastCellModel(from: forecast))
                self?.view.reloadData()
            }.onFailure { [weak self] error in
                self?.onError(error: error)
            }
            .run().disposed(by: disposeBag)
    }
}
