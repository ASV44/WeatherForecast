import RxSwift

class BaseInteractor<V> {
    internal var view: V!
    
    let disposeBag: DisposeBag
    
    init() {
        self.disposeBag = DisposeBag()
    }
    
    func bind(view: V) {
        self.view = view
    }
    
    func onError(error: Error) {
        guard let view = self.view as? BaseView,
              let exception = error as? Exception else { return }
        switch exception {
        case .HTTP(let error, let data):
            view.onError(error: decodeApiError(from: data) ?? Errors.Error(message: error.localizedDescription))
            break
        case .NetworkConnection:
            view.onError(error: Errors.NETWORK_CONNECTION_ERROR)
            break
        }
    }
    
    private func decodeApiError(from data: Data?) -> Errors.Error? {
        guard let rawData = data,
              let apiError = try? JSONDecoder().decode(Errors.Error.self, from: rawData) else { return nil }
        
        return apiError
    }
}
