import RxSwift

protocol APIService {
    func getCurrentWeather(for city: String) -> Observable<Forecast>
}
