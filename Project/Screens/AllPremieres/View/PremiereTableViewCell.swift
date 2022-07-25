import AlamofireImage
import Domain
import RxSwift
import UIKit

final class PremiereTableViewCell: BaseTableViewCell {
    // MARK: - PRIVATE PROPERTIES

    private var coverImageView: UIImageView = .init(image: nil, contentMode: .scaleAspectFit)
    private var nameLabel: UILabel = .init(font: .systemFont(ofSize: 18, weight: .bold))
    private var descriptionLabel: UILabel = .init(font: .systemFont(ofSize: 14), numberOfLines: 3)

    private var didSetupConstraints: Bool = false

    // MARK: - INITIALIZERS

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(_ premiere: Premiere) {
        let downloadURL = URL(string: premiere.coverURL)!
        coverImageView.af.setImage(withURL: downloadURL, placeholderImage: UIImage(named: "placeholder"))
        nameLabel.text = premiere.name
        descriptionLabel.text = premiere.description
    }
}

// MARK: - UI LAYOUT

extension PremiereTableViewCell {
    private func setupView() {
        selectionStyle = .none
        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        contentView.addSubviews([coverImageView, nameLabel, descriptionLabel])
        setNeedsUpdateConstraints()
    }

    private func addConstraints() {
        if !didSetupConstraints {
            coverImageView.snp.makeConstraints {
                $0.top.leading.equalToSuperview().offset(Config.defaultPadding)
                $0.width.height.equalTo(90)
                $0.bottom.equalToSuperview().inset(Config.defaultPadding)
            }
            nameLabel.snp.makeConstraints {
                $0.top.equalTo(coverImageView.snp.top)
                $0.leading.equalTo(coverImageView.snp.trailing).offset(Config.defaultPadding)
                $0.trailing.equalToSuperview().inset(Config.defaultPadding)
            }
            descriptionLabel.snp.makeConstraints {
                $0.top.equalTo(nameLabel.snp.bottom).offset(Config.defaultPadding)
                $0.leading.trailing.equalTo(nameLabel)
            }
            didSetupConstraints = true
        }
    }
}
