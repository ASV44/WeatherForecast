import RxSwift

extension Observable {
    @discardableResult
    public func onSuccess(_ block: @escaping (Element) -> Void) -> Observable<Element> {
        return self.do(onNext: block)
    }
    
    @discardableResult
    public func onFailure(_ block: @escaping (Error) -> Void) -> Observable<Element> {
        return self.do(onError: block)
    }
    
    func run() -> Disposable {
        let scheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        return subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe()
    }
}
