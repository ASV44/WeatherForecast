class Errors {
    struct Error: Codable {
        let cod: String?
        let message: String
        var description: String {
            get {
                guard let errorCode = cod else { return message }
                return message + "\n" + errorCode
            }
        }
    }
    
    static let GENERAL_ERROR = Error(cod: "-1", message: "Unknown error")
    static let NETWORK_CONNECTION_ERROR = Error(cod: "1", message: "Internet connection error")
}

extension Errors.Error {
    init(message: String) {
        self.cod = nil
        self.message = message
    }
}
