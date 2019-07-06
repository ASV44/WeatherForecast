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
    
    func execute<T>(_ observable: Observable<T>, _ onNext: @escaping (T) -> (), _ onError: @escaping (Error) -> ()) {
        let scheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        let subscription = observable.subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { data in
                onNext(data)
            }, onError: { error in
                onError(error)
            })
        disposeBag.insert(subscription)
    }
    
    func onError(error: Error) {
        guard let view = self.view as? BaseView,
              let exception = error as? Exception else { return }
        switch exception {
        case .HTTP(let error):
            view.onError(error: Errors.Error(message: error.localizedDescription))
            break
        case .NetworkConnection:
            view.onError(error: Errors.NETWORK_CONNECTION_ERROR)
            break
        }
    }
}
