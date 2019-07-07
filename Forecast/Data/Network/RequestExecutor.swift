import RxSwift
import Alamofire

final class RequestExecutor {
    func execute<T: Codable>(to url: String,
                             with parameters: Parameters!,
                             method: HTTPMethod,
                             headers: HTTPHeaders? = nil) -> Observable<T> {
        guard Reachability.isConnectedToNetwork() else { return Observable.error(Exception.NetworkConnection) }
        return getRequest(to: url, with: parameters, method: method, headers: headers)
    }
    
    func getRequest<T: Codable>(to url: String,
                       with parameters: Parameters!,
                       method: HTTPMethod,
                       headers: HTTPHeaders? = nil) -> Observable<T> {
        return Observable.create { observer in
            let request = AF.request(url,
                                     method: method,
                                     parameters: parameters,
                                     encoding: URLEncoding.queryString,
                                     headers: headers)
                .validate().responseDecodable { (response: DataResponse<T>)  in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(Exception.HTTP(error: error, data: response.data))
                    }
            }
            request.resume()
            
            return Disposables.create { request.cancel() }
        }
    }
}
