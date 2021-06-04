
import UIKit

extension WeatherViewController {
  
  func renderProps(_ props: WeatherViewModel.Props) {
    switch props {
    
    case .loading:
      resetAllLabels()
      cityLabel.text = "Loading..."
      
    case .failed(let errorDescr):
      resetAllLabels()
      cityLabel.text = errorDescr
      
    case .locationDefined(let location):
      cityLabel.text = location
      
    case .weatherInfo(let info):
      dateLabel.text = info.date
      currentIcon.image = info.icon
      currentSummaryLabel.text = info.summary
      forecastSummary.text = info.forecastSummary
    }
  }
  
}


class WeatherViewController: UIViewController {
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentIcon: UIImageView!
  @IBOutlet weak var currentSummaryLabel: UILabel!
  @IBOutlet weak var forecastSummary: UITextView!
  
  private let viewModel = WeatherViewModel(defaultAddress: "Екатеринбург")
  
  
  // MARK: - VC Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
  }
  
  
  // MARK: - IBActions
  
  @IBAction func promptForLocation(_ sender: Any) {
    showLocationEnterAlert()
  }
  
}


// MARK: - Binds
private extension WeatherViewController {
  
  func bindViewModel() {
    viewModel.props.bind { [weak self] props in
      self?.renderProps(props)
    }
  }
  
}


// MARK: - Impl
private extension WeatherViewController {
  
  func showLocationEnterAlert() {
    let alert = UIAlertController(title: "Choose location", message: nil, preferredStyle: .alert)
    alert.addTextField()
    
    let submitAction = UIAlertAction(title: "Submit",
                                     style: .default) { [unowned alert, weak self] _ in
      guard let newLocation = alert.textFields?.first?.text else { return }
      self?.viewModel.changeLocation(to: newLocation)
    }
    
    alert.addAction(submitAction)
    alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
    
    present(alert, animated: true)
  }
  
  func resetAllLabels() {
    cityLabel.text = nil
    dateLabel.text = nil
    currentIcon.image = nil
    currentSummaryLabel.text = nil
    forecastSummary.text = nil
  }
  
}
