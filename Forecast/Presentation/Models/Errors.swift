class Errors {
    
    struct Error {
        let code: Int?
        let message: String
        var description: String {
            get {
                guard let errorCode = code else { return message }
                return String(errorCode) + "\n" + message
            }
        }
    }
    
    static let GENERAL_ERROR = Error(code: -1, message: "Unknown error")
    static let NETWORK_CONNECTION_ERROR = Error(code: 1, message: "Internet connection error")
}

extension Errors.Error {
    init(message: String) {
        self.code = nil
        self.message = message
    }
}
