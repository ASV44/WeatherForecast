final class ForecastInteractor {
    var view: ForecastView!
    var cellModels: [ForecastCellModel] = []
    
    init(view: ForecastView) {
        self.view = view
    }
}
