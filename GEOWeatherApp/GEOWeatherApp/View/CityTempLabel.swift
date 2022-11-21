import UIKit
final class CityTempLabel: UIView {
    // MARK: - Privates
    private let cityTempLabel = UILabel()
    // MARK: - Properties
    var text: String {
        get {
            cityTempLabel.text ?? ""
        }
        set {
            cityTempLabel.text = newValue
        }
    }
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupUI()
        addConstrainst()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setups
    private func addSubviews() {
        addSubview(cityTempLabel)
    }
    private func setupUI() {
        cityTempLabel.textColor = .blue
        cityTempLabel.font = .systemFont(ofSize: 25)
        cityTempLabel.textAlignment = .center
        cityTempLabel.backgroundColor = .clear
    }
    private func addConstrainst() {
        // cityTempLabel Constraints
        cityTempLabel.translatesAutoresizingMaskIntoConstraints = false
        cityTempLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cityTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cityTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cityTempLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
