
import Foundation

// see https://openweathermap.org/current#current_JSON for details
struct WeatherbitData: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case observation = "data"
  }
  
  private static let dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  
  //MARK: - JSON Decodables
  
  let observation: [Observation]
  
}

extension WeatherbitData {
  
  struct Observation: Decodable {
    let temp: Double
    let datetime: String
    let weather: Weather
  }
  
}

extension WeatherbitData.Observation {
  
  struct Weather: Decodable {
    let icon: String
    let description: String
  }
  
}

//MARK: - Convenience getters
extension WeatherbitData {
  
  var currentTemp: Double {
    observation[0].temp
  }
  
  var iconName: String {
    observation[0].weather.icon
  }
  
  var description: String {
    observation[0].weather.description
  }
  
  var date: Date {
    //strip off the time
    let dateString = String(observation[0].datetime.prefix(10))
    //use current date if unable to parse
    return Self.dateFormatter.date(from: dateString) ?? Date()
  }
  
}

