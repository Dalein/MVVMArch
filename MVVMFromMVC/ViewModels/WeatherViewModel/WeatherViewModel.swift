
import Foundation


extension WeatherViewModel {
  
  enum Props {
    case loading
    case failed(String)
    case locationDefined(String)
    case weatherInfo(WeatherDataViewModel)
  }
  
}

class WeatherViewModel {
  let defaultAddress: String
  
  private let geocoder = LocationGeocoder()
  private let vmFormatter = WeatherDataViewModelFormatter()
  
  
  // MARK: - Bindings
  
  let props = Box(Props.loading)
  
  
  // MARK: - API
  
  func changeLocation(to newLocation: String) {
    props.value = .loading
    
    geocoder.geocode(addressString: newLocation) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      
      case .success(let location):
        self.props.value = .locationDefined(location.name)
        self.fetchWeatherForLocation(location)
        
      case .failure(let error):
        self.fillViewModelLocationBotFound(error)
      }
    }
  }
  
  
  // MARK: - Init
  
  init(defaultAddress: String) {
    self.defaultAddress = defaultAddress
    changeLocation(to: defaultAddress)
  }
  
}


// MARK: - Impl

private extension WeatherViewModel {
  
  func fetchWeatherForLocation(_ location: Location) {
    WeatherbitService.weatherDataForLocation(latitude: location.latitude,
                                             longitude: location.longitude) { [weak self] weatherData, error in
      guard let self = self,
            let weatherData = weatherData else { return }
      self.fillViewModel(by: weatherData)
    }
    
  }
  
}


// MARK: - Fill VM binded values
private extension WeatherViewModel {
  
  func fillViewModel(by weatherData: WeatherbitData) {
    props.value = .weatherInfo(vmFormatter.format(weatherData: weatherData))
  }
  
  func fillViewModelLocationBotFound(_ error: NSError) {
    props.value = .failed("Not found (\(error.localizedDescription)")
  }
  
}
