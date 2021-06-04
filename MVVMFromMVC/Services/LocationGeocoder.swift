
import Foundation
import CoreLocation

class LocationGeocoder {
  private lazy var geocoder = CLGeocoder()
  
  
  // MARK: - API
  
  /// Convert a place name to a location
  func geocode(addressString: String, callback: @escaping (Result<Location, NSError>) -> ()) {
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
      guard error == nil else {
        return callback(.failure(error! as NSError))
      }
      
      guard let placemark = placemarks?.first else {
        return callback(.failure(NSError(domain: "LocationGeocoder", code: -1, userInfo: nil)))
      }
      
      guard let name = placemark.locality, let location = placemark.location else {
        return callback(.failure(NSError(domain: "LocationGeocoder", code: -2, userInfo: nil)))

      }
      let region = placemark.administrativeArea ?? ""
      let fullName = "\(name), \(region)"
      
      callback(.success(.init(name: fullName,
                              latitude: location.coordinate.latitude,
                              longitude: location.coordinate.longitude)))
    }
  }
  
}
