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
        interactor = ForecastInteractor(view: self)
    }

    private func registerNibs() {
        tableView.register(ForecastCell.nib, forCellReuseIdentifier: ForecastCell.identifier)
    }

}

extension ForecastViewController: ForecastView {
    
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.identifier,
                                                       for: indexPath) as? ForecastCell else { return UITableViewCell() }
        
        return cell
    }
    
}
