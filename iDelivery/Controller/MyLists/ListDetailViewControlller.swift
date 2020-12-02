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
    var users = [
            UserList(userID: "12", name: "Afatim Bor", phone: "09299393", image: "aj"),
            UserList(userID: "1", name: "Kibaro Lofi", phone: "30399393", image: "aja"),
            UserList(userID: "33", name: "Staki bandi", phone: "388388", image: "aj"),
            UserList(userID: "3", name: "McBoff Li", phone: "338383", image: "aia")
        ]

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
    
    @objc func handleButton() {
        let addLiost = AddListViewController()
        present(addLiost, animated: true)
    }
    
    private func setupSource() {
        var snapshot = source.snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(users,toSection: .main)
//        snapshot
        source.apply(snapshot)
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            completion(true)
            
            var snapshot = self.source.snapshot()
            
            // figure out the contact we need to delete
            guard let userList = self.source.itemIdentifier(for: indexPath) else { return }
            
            snapshot.deleteItems([userList])
            self.users.remove(at: indexPath.item)
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
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imagDefauls = UIImageView(image : #imageLiteral(resourceName: "undraw_Add_notes_re_ln36"))
        let hStack = HStackView(arrangedSubviews: [UIView(),imagDefauls,UIView()], spacing: 5)
        hStack.distribution = .equalCentering
        imagDefauls.constrainHeight(constant: 200)
        imagDefauls.constrainWidth(constant: 200)
        imagDefauls.isUserInteractionEnabled = true
     if users.count == 0 {
            imagDefauls.isHidden = false
            return hStack
        } else {
            imagDefauls.isHidden = true
            return UIView()
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if users.count == 0 {
            return 400
        }
        return 0
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
