//
//  ListDetailViewControlller.swift
//  iDelivery
//
//  Created by mac on 11/28/20.
//

import SwiftUI
import CoreData

enum SectionType {
    case main
}
class UserListSource : UITableViewDiffableDataSource<SectionType,Item> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}
class ListDetailViewControlller: UITableViewController {
    var items = [Item]()
    var parentList : List? {
        didSet {
            setupSource()
        }
    }
    
    private let cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
    }
    deinit {
        print("No Ratain Cycle For Items in List")
    }
    
    lazy var source : UserListSource = .init(tableView: self.tableView) { (tableView, indexPath, item) -> UITableViewCell? in
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! ListDetailViewCell
        cell.item = item
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
        let fetchItems : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "parentList.id == %@","\(parentList?.id ?? UUID())")
        fetchItems.predicate = predicate
        print(" in Setup :  \(parentList?.name ?? "AZO"))")
        
        do {
            let fetchedList =  try PersistenceServce.context.fetch(fetchItems)
            self.items = fetchedList
            var snapshot = source.snapshot()
            snapshot.appendSections([.main])
            fetchedList.forEach({print($0.city ?? "NO" )})
            snapshot.appendItems(items,toSection: .main)
            source.apply(snapshot)
            tableView.dataSource = source
        } catch let errorLoadItems {
            print("Somthing Wroong reason : ",errorLoadItems.localizedDescription)
        }
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (action, view, completion) in
            completion(true)
            
            var snapshot = self.source.snapshot()
            
            // figure out the contact we need to delete
            guard let userList = self.source.itemIdentifier(for: indexPath) else { return }
            let item = items[indexPath.item]
            PersistenceServce.context.delete(item)
            print("The stuff been deleted 😎")
            PersistenceServce.saveContext()
            snapshot.deleteItems([userList])
            self.items.remove(at: indexPath.item)
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
     if items.count == 0 {
            imagDefauls.isHidden = false
            return hStack
        } else {
            imagDefauls.isHidden = true
            return UIView()
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if items.count == 0 {
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
