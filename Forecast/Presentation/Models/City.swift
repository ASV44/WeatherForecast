struct City: Codable, Equatable {
    var name: String
    var cod: String
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name && lhs.cod == rhs.cod
    }
}
