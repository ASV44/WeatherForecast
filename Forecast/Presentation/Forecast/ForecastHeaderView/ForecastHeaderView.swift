import UIKit

final class ForecastHeaderView: UITableViewHeaderFooterView {
    static var identifier = "ForecastHeaderView"
    
    @IBOutlet var regionTitleLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}
