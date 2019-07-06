import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    private var interactor: ForecastInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInteractor()
        registerNibs()
    }
    
    private func setInteractor() {
        interactor = ForecastInteractor(apiService: APICommunication())
        interactor.bind(view: self)
    }

    private func registerNibs() {
        tableView.register(ForecastCell.nib, forCellReuseIdentifier: ForecastCell.identifier)
    }

    @IBAction func searchAction(_ sender: UIButton) {
        guard let city = textField.text  else { return }
        interactor.fetchCurrentWeatherForecast(for: city)
    }
}

extension ForecastViewController: ForecastView {
    func onError(error: Errors.Error) {
        print(error.description)
    }
    
    func reloadData() {
        textField.text = ""
        tableView.reloadData()
    }
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.identifier,
                                                       for: indexPath) as? ForecastCell else { return UITableViewCell() }
        cell.configure(with: interactor.cellModels[indexPath.row])
        
        return cell
    }
    
}
