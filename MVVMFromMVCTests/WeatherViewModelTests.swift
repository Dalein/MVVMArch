import XCTest
@testable import Grados

class WeatherViewModelTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testChangeLocationUpdatesLocationName() {
    let expectation = self.expectation(description: "Find location using geocoder")
    
    let viewModel = WeatherViewModel()
    
    viewModel.locationName.bind {
      print("$0: \($0)")
      if $0.caseInsensitiveCompare("Richmond, VA") == .orderedSame {
        expectation.fulfill()
      }
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      viewModel.changeLocation(to: "Ричмонд, VA")
    }
    
    waitForExpectations(timeout: 10, handler: nil)
  }
  
}
