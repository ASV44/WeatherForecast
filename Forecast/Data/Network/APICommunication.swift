import Alamofire
import RxSwift

final class APICommunication: APIService {
    
    private let requestExecutor: RequestExecutor
    
    init() {
        requestExecutor = RequestExecutor()
    }
    
    func getCurrentWeather(for city: String) -> Observable<Forecast> {
        return requestExecutor.execute(to: Url.weather, with: getRequestParams(for: city), method: HTTPMethod.get)
    }
    
    private func getRequestParams(for query: String) -> Parameters {
        return ["q": query,
                "APPID": "39e13433e1b11c6d3c8410e3170e3926"]
    }
}
