//
//  CreateListViewController.swift
//  iDelivery
//
//  Created by mac on 12/2/20.
//

import SwiftUI
import CoreData

enum SectionList {
    case main
}
class CreateListDataSource : UITableViewDiffableDataSource<SectionList,List> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
class CreateListViewController: UITableViewController {
    var list = [List]()
    var item : Item?
   
    let button = UIButton(type : .system)
    private let cellID = "CellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        creatUI()
    }
    
    lazy var source : CreateListDataSource = .init(tableView: self.tableView) { (tableView, indexPath, list) -> UITableViewCell? in
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! CreateListViewCell
        cell.list = list
        return cell
    }
    
}

extension CreateListViewController {
    func configureHierarchy() {
        view.backgroundColor = .secondarySystemBackground
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(CreateListViewCell.self, forCellReuseIdentifier: cellID)
        setupSource()
    }
    private func setupSource() {
        let fetchLists : NSFetchRequest<List> = List.fetchRequest()
        do {
            let fetchedList =  try PersistenceServce.context.fetch(fetchLists)
            self.list = fetchedList
            self.list.forEach({print("IDs :\($0.id ?? UUID()) \n")})
            var snapshot = source.snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.list, toSection: .main)
            source.apply(snapshot,animatingDifferences: true)
            tableView.dataSource = source
        } catch let errorLoadLists {
            print("Somthing Wroong reason : ",errorLoadLists.localizedDescription)
        }
    }
    fileprivate func setActions() {
        button.addTarget(self, action: #selector(handleCreateList), for: .touchUpInside)
    }

    @objc fileprivate func handleCreateList() {
        let creatListViewController = AddListViewController()
        creatListViewController.didAddList = { [weak self] name, color in
            let newList = List(context: PersistenceServce.context)
            newList.color = color.encode()
            newList.name = name
            newList.id = UUID()
            PersistenceServce.saveContext()
            self?.list.append(newList)
            var snapshot = self?.source.snapshot()
            snapshot?.appendItems([newList])
            self?.source.apply(snapshot!)
            self?.dismiss(animated: true)
        }
        present(creatListViewController, animated: true)
    }
    fileprivate func creatUI() {
        setActions()

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parentList = list[indexPath.item]
        
        let newItem = Item(context: PersistenceServce.context)
        newItem.city    = item?.city
        newItem.email   = item?.email
        newItem.image   = item?.image
        newItem.price   = item?.price ?? "00"
        newItem.returns = item?.returns ?? "00"
        newItem.stock   = item?.stock ?? "00"
        newItem.machine = item?.machine ?? 0
        newItem.name    = item?.name
        newItem.id      = item?.id
        newItem.phone   = item?.phone
        newItem.parentList = parentList
        PersistenceServce.saveContext()
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        dismiss(animated: true)
    }

   
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imagDefauls = UIImageView(image : #imageLiteral(resourceName: "undraw_No_data_re_kwbl"))
        let hStack = HStackView(arrangedSubviews: [UIView(),imagDefauls,UIView()], spacing: 5)
        hStack.distribution = .equalCentering
        imagDefauls.constrainHeight(constant: 200)
        imagDefauls.constrainWidth(constant: 200)
        imagDefauls.isUserInteractionEnabled = true
     if list.count == 0 {
            imagDefauls.isHidden = false
            return hStack
        } else {
            imagDefauls.constrainWidth(constant: 0)
            imagDefauls.constrainHeight(constant: 0)
            imagDefauls.isHidden = true
            return UIView()
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if list.count == 0 {
            return 400
        }
        return 50
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .medium)
            
            button.setImage(UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.list,withConfiguration: configuration)!, string: "Create New List", color: .white, imageAlignment: 0, segFont: UIFont.systemFont(ofSize: 30, weight: .semibold)), for: .normal)
            button.layer.cornerRadius = 5
            button.shadow()
            button.backgroundColor = .niceBlue
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleCreateList), for: .touchUpInside)
        let randomView = UIView()
        randomView.constrainHeight(constant: 35)
        let vStack = VerticalStackView(arrangedSubviews: [randomView,button], spacing: 10)
        
            return vStack
    
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
struct CreateListView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let createListViewController = CreateListViewController()
        return createListViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct CreateListViewController_Previews: PreviewProvider {
    static var previews: some View {
        CreateListView()
            .edgesIgnoringSafeArea(.all)
    }
}
