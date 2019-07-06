struct Url {
    
    private struct Domains {
        static let Dev = "http://api.openweathermap.org"
        static let QA = ""
    }
    
    private  struct Routes {
        static let Api = "/data/2.5"
    }
    
    private  static let Domain = Domains.Dev
    private  static let Route = Routes.Api
    private  static let BaseURL = Domain + Route
    
    static var weather: String {
        return BaseURL  + "/weather"
    }
}
