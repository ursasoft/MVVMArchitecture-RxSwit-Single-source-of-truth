import Domain
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class PremieresView: UIView {
    private let viewModel: PremieresViewModel
    private let tableView: UITableView = .createTableView(cellClasses: [PremiereTableViewCell.self])

    // MARK: - INITIALIZERS

    init(viewModel: PremieresViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        setupObservers()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI LAYOUT

extension PremieresView {
    private func setupView() {
        backgroundColor = .white
        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        addSubviews([tableView])
    }

    private func addConstraints() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - OBSERVERS

extension PremieresView {
    private func setupObservers() {
        bindTableView()
    }

    private func bindTableView() {
        viewModel.premieres
            .skip(1)
            .bind(to:
                tableView.rx.items(cellIdentifier: PremiereTableViewCell.reuseID, cellType: PremiereTableViewCell.self)
            ) { _, premiere, cell in
                cell.selectionStyle = .none
                cell.bind(premiere)
            }.disposed(by: viewModel.disposeBag)

        viewModel.toastState
            .map {
                switch $0 {
                case .indicator:
                    return true
                default:
                    return false
                }
            }
            .bind(to: tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: viewModel.disposeBag)

        tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asObservable().bind { [weak self] in
                self?.viewModel.fetchPremieres()
            }.disposed(by: viewModel.disposeBag)

        tableView.rx.modelSelected(Premiere.self).subscribe(onNext: { [weak self] in
            self?.viewModel.showDetails($0)
        }).disposed(by: viewModel.disposeBag)
    }
}
