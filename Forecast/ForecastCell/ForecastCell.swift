import UIKit

final class ForecastCell: UITableViewCell {
    static var identifier = "ForecastCell"
    
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var humidityValueLabel: UILabel!
    @IBOutlet private var windSpeedValueLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with cellModel: ForecastCellModel) {
        cityLabel.text = cellModel.city
        temperatureLabel.text = cellModel.temperature
        humidityValueLabel.text = String(cellModel.humidity)
        windSpeedValueLabel.text = String(cellModel.windSpeed)
        descriptionLabel.text = cellModel.description
    }
}
