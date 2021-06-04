
import Foundation
import CoreLocation

struct Location: Equatable {
  let name: String
  let latitude: Double
  let longitude: Double
  
  var location: CLLocation {
    CLLocation(latitude: latitude,
               longitude: longitude)
  }
  
}
