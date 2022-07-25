import UIKit

// MARK: - EXTENSION DEFINITION

extension UITableView {
    static func createTableView(estimatedRowHeight: CGFloat = 106,
                                cellClasses: [UITableViewCell.Type] = []) -> UITableView {
        let tableView = UITableView()
        tableView.refreshControl = UIRefreshControl()
        tableView.backgroundColor = .white
        tableView.sectionIndexBackgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.keyboardDismissMode = .onDrag
        cellClasses.forEach {
            tableView.register($0, forCellReuseIdentifier: String(describing: $0))
        }
        return tableView
    }
}
