//
//  ListDetailViewControlller.swift
//  iDelivery
//
//  Created by mac on 11/28/20.
//

import SwiftUI


enum SectionType {
    case main
}
class UserListSource : UITableViewDiffableDataSource<SectionType,UserList> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}
class ListDetailViewControlller: UITableViewController {
   private let cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
    }
    
    lazy var source : UserListSource = .init(tableView: self.tableView) { (tableView, indexPath, userList) -> UITableViewCell? in
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! ListDetailViewCell
        cell.userList = userList
        return cell
    }
}

extension ListDetailViewControlller {
    func configureHierarchy() {
        tableView.register(ListDetailViewCell.self, forCellReuseIdentifier: cellID)
        navigationItem.title = "Squad List"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupSource()
        menus()
    }

    private func setupSource() {
        var snapshot = source.snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems([
            .init(userID: "1", name: "Amine Jabir", phone: "Phone",image: "Image"),
            .init(userID: "2", name: "Yasser Zawin", phone: "Phone",image: "Image"),
            .init(userID: "3", name: "Zobir Modarif", phone: "Phone",image: "Image"),
            .init(userID: "4", name: "Samir Khadiri", phone: "Phone",image: "Image"),
            .init(userID: "5", name: "Saad Saissi Hassani", phone: "Phone",image: "Image")
           ],toSection: .main)
        source.apply(snapshot)
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            completion(true)
            
            var snapshot = self.source.snapshot()
            
            // figure out the contact we need to delete
            guard let userList = self.source.itemIdentifier(for: indexPath) else { return }
            
            snapshot.deleteItems([userList])
            
            self.source.apply(snapshot)
        }
        return .init(actions: [deleteAction])
    }
    //Edite Menu
    fileprivate func menus(with color : UIColor = .niceBlue) {
        let filters = UIMenu(title: "", children: [
                                UIAction(title: "Name & Appearance", image: UIImage(systemName: SFSymbols.pencil), handler: handelMenu),
                                UIAction(title: "Select Users", image: UIImage(systemName: SFSymbols.check), handler: handelMenu),
            UIAction(title: "Delete List", image: UIImage(systemName: SFSymbols.trash), attributes: .destructive, handler: handelMenu)
                                ])
        let barItem = UIBarButtonItem(title: "", image: UIImage(systemName: SFSymbols.setFiltering)!.withTintColor(color).withRenderingMode(.alwaysOriginal), menu: filters)
        navigationItem.rightBarButtonItem = barItem
        
    }
     func handelMenu(action: UIAction) {
        print("Dreams Jma3a Chmal... ")
    }
}
struct ListDetailView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = ListDetailViewControlller(style: .insetGrouped)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
}

struct ListDetailViewControlller_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView()
            .edgesIgnoringSafeArea(.all)
    }
}
