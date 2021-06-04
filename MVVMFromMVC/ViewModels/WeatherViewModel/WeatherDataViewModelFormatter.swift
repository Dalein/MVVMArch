
import Foundation
import UIKit.UIImage


struct WeatherDataViewModel {
  let date: String
  let icon: UIImage?
  let summary: String
  let forecastSummary: String
}


class WeatherDataViewModelFormatter {
  
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter
  }()
  
  private let tempFormatter: NumberFormatter = {
    let tempFormatter = NumberFormatter()
    tempFormatter.numberStyle = .none
    return tempFormatter
  }()
  
  
  // MARK: - API
  
  func format(weatherData: WeatherbitData) -> WeatherDataViewModel {
    let date = dateFormatter.string(from: weatherData.date)
    let icon = UIImage(named: weatherData.iconName)
    
    let temp = tempFormatter.string(from: weatherData.currentTemp as NSNumber) ?? ""
    let summary = "\(weatherData.description), \(temp) C"
    let forecastSummary = "\nSummary: \(weatherData.description)"
    
    return WeatherDataViewModel(
      date: date,
      icon: icon,
      summary: summary,
      forecastSummary: forecastSummary)
  }
  
}
