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
        tableView.register(ForecastHeaderView.nib, forHeaderFooterViewReuseIdentifier: ForecastHeaderView.identifier)
    }

    @IBAction func searchAction(_ sender: UIButton) {
        guard let city = textField.text  else { return }
        interactor.fetchCurrentWeatherForecast(for: city)
    }
}

extension ForecastViewController: ForecastView {
    func onError(error: Errors.Error) {
        print(error.description)
        textField.text = ""
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func reloadData() {
        textField.text = ""
        tableView.reloadData()
    }
}

extension ForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countrySection = interactor.sections[section]
        return interactor.cellModels[countrySection]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.identifier,
                                                       for: indexPath) as? ForecastCell else { return UITableViewCell() }
        let countrySection = interactor.sections[indexPath.section]
        guard let sectionCellModels = interactor.cellModels[countrySection] else { return UITableViewCell() }
        cell.configure(with: sectionCellModels[indexPath.row])
        
        return cell
    }
}

extension ForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ForecastHeaderView.identifier)
        guard let header = view as? ForecastHeaderView else { return nil }
        header.regionTitleLabel.text = interactor.sections[section]
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
