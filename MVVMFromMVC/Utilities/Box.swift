import Foundation

final class Box<T> {
  typealias Listener = (T) -> ()
  
  private var listener: Listener?
  
  
  // MARK: - API
  
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
  
  
  // MARK: - Init
  
  init(_ value: T) {
    self.value = value
  }
  
}
