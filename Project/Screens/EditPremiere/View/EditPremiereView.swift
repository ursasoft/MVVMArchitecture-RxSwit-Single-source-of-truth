import Domain
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class EditPremiereView: UIView {
    // MARK: - PRIVATE PROPERTIES

    private let viewModel: EditPremiereViewModel
    private let nameTextField: UITextField = .init(placeholder: "Name",
                                                   rightViewImage: UIImage(systemName: "1.square"))
    private let coverUrlTextField: UITextField = .init(placeholder: "Cover URL",
                                                       rightViewImage: UIImage(systemName: "2.square"))
    private let descriptionTextField: UITextField = .init(placeholder: "Description",
                                                          rightViewImage: UIImage(systemName: "3.square"))

    // MARK: - INITIALIZERS

    init(viewModel: EditPremiereViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        nameTextField.text = viewModel.premiere.name
        coverUrlTextField.text = viewModel.premiere.coverURL
        descriptionTextField.text = viewModel.premiere.description

        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var input: Input {
        return (name: nameTextField.rx.text.orEmpty.asObservable(),
                coverUrl: coverUrlTextField.rx.text.orEmpty.asObservable(),
                description: descriptionTextField.rx.text.orEmpty.asObservable())
    }
}

// MARK: - UI LAYOUT

extension EditPremiereView {
    private func setupView() {
        backgroundColor = .white
        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        addSubviews([nameTextField, coverUrlTextField, descriptionTextField])
    }

    private func addConstraints() {
        nameTextField.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Config.defaultPadding)
            $0.trailing.equalToSuperview().inset(Config.defaultPadding)
        }

        coverUrlTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(Config.defaultPadding)
            $0.leading.trailing.equalTo(nameTextField)
        }

        descriptionTextField.snp.makeConstraints {
            $0.top.equalTo(coverUrlTextField.snp.bottom).offset(Config.defaultPadding)
            $0.leading.trailing.equalTo(nameTextField)
        }
    }
}
