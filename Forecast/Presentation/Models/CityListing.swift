final class CityListing: Codable {
    var cities: [City]
    
    init() {
        cities = []
    }
    
    func add(city name: String, cod: String) {
        let city = City(name: name, cod: cod)
        if let _ = cities.firstIndex(of: city) { return }
        cities.insert(city, at: 0)
    }
    
    func add(city: City) {
        if let _ = cities.firstIndex(of: city) { return }
        cities.insert(city, at: 0)
    }
    
    func add(cities: [City]) {
        self.cities.append(contentsOf: cities)
    }
}

extension CityListing:  Cacheable {
    var fileName: String { return "cachedCitiesList.json"}
}
