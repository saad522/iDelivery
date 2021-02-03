//
//  MyListViewController.swift
//  iDelivery
//
//  Created by mac on 11/27/20.
//

import SwiftUI
import CoreData

class MyListViewController: UICollectionViewController {
 
    
    //MARK: Properties
    var list = [List]()
    private let cellID = "cellID"
    let listImage = UIImageView(image : #imageLiteral(resourceName: "undraw_No_data_re_kwbl"))
    let message = "Create your own lists".localized
    
   lazy var listTitle = UILabel.init(text: self.message, font: .systemFont(ofSize: 35, weight: .semibold), numberOfLines: 2)
    
    enum Section {
        case main
    }
 
    deinit {
        print("No Retain cycle For List")
    }
    init() {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(95)), subitems: [item])
        group.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNvigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "My Lists".localized
        listTitle.text = message
        let fetchLists : NSFetchRequest<List> = List.fetchRequest()
        do {
            let fetchedList =  try PersistenceServce.context.fetch(fetchLists)
            self.list = fetchedList
            self.list.forEach({print("IDs :\($0.id ?? UUID()) \n")})
            self.collectionView.reloadData()
//            var snapshot = diffableDataSource.snapshot()
//            snapshot.appendItems(self.list)
//            diffableDataSource.apply(snapshot,animatingDifferences: false)
//            collectionView.dataSource = diffableDataSource
        } catch let errorLoadLists {
            print("Somthing Wroong reason : ",errorLoadLists.localizedDescription)
        }
        if let downcastStrings = self.tabBarController?.tabBar.items
        {
            downcastStrings[0].title = "Nearby".localized
            downcastStrings[1].title = "My Lists".localized
            downcastStrings[2].title = "Settings".localized
            
        }
    }
}

//MARK: setup Core-Data
extension MyListViewController {
    @objc func handleAddNewList() {
        print("Presnting AddListViewController...")
        let addListViewController = AddListViewController()
        addListViewController.didAddList = { [weak self] name, color in
            let newList = List(context: PersistenceServce.context)
            newList.color = color.encode()
            newList.name = name
            newList.id = UUID()
            PersistenceServce.saveContext()
            self?.list.append(newList)
            self?.collectionView.reloadData()
//            var snapshot = self?.diffableDataSource.snapshot()
//            snapshot?.appendItems([newList])
//            self?.diffableDataSource.apply(snapshot!)
            self?.dismiss(animated: true)
        }
        
        present(addListViewController, animated: true)
    }
}
//MARK: Configure CollectionView
extension MyListViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listImage.isHidden = list.count != 0
        listTitle.isHidden = list.count != 0
        return list.count
    }
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
//        print("Captured Long Press")

        let location = gesture.location(in: collectionView)

        guard let selectedIndexPath = collectionView?.indexPathForItem(at: location) else { return }

        print(selectedIndexPath.item)

        let alertController = UIAlertController(title: "Remove Podcast?", message: nil, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            let selectedList = self.list[selectedIndexPath.item]
            // where we remove the podcast object from collection view
            self.list.remove(at: selectedIndexPath.item)
            self.collectionView?.deleteItems(at: [selectedIndexPath])
            // also remove your favorited podcast from UserDefaults
            // The simulator doesn't delete immediately, test with your physical iPhone devices
            PersistenceServce.context.delete(selectedList)
            PersistenceServce.saveContext()
            print("DEBUG: Delete")
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertController, animated: true)
    }
    fileprivate func setUpNvigation() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView?.addGestureRecognizer(gesture)
        navigationController?.navigationBar.prefersLargeTitles = true
       
        collectionView.backgroundColor = .secondarySystemBackground
        let barItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.addList)?.withTintColor(.label).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddNewList))
        navigationItem.rightBarButtonItem = barItem
        cellRefistration()
        setupSource()
        creatUI()
    }
    fileprivate func creatUI() {
        let vStack = VerticalStackView(arrangedSubviews: [listImage,listTitle], spacing: 5)
        vStack.alignment = .center
        listImage.constrainWidth(constant: 300)
        listImage.constrainHeight(constant: 300)
        collectionView.addSubview(vStack)
        vStack.anchor(top: collectionView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! ListViewCell
        
        cell.circle.backgroundColor = UIColor.color(data: list[indexPath.item].color!)
        cell.name.text = list[indexPath.item].name
        cell.numberOfItemInList.text = "\(list[indexPath.item].items?.count ?? 0)"
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let parentList = list[indexPath.item]
        let listDeatail = ListDetailViewControlller(style: .insetGrouped)
        listDeatail.parentList = parentList
        navigationController?.pushViewController(listDeatail, animated: true)
        print("HOLO...")
    }
    fileprivate func cellRefistration() {
        collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: cellID)
    }
 
    fileprivate func setupSource() {
        let fetchLists : NSFetchRequest<List> = List.fetchRequest()
        do {
            let fetchedList =  try PersistenceServce.context.fetch(fetchLists)
            self.list = fetchedList
            self.list.forEach({print("IDs :\($0.id ?? UUID()) \n")})
            collectionView.reloadData()
//            var snapshot = diffableDataSource.snapshot()
//            snapshot.appendSections([.main])
//            snapshot.appendItems(self.list, toSection: .main)
//            diffableDataSource.apply(snapshot,animatingDifferences: false)
//            collectionView.dataSource = diffableDataSource
        } catch let errorLoadLists {
            print("Somthing Wroong reason : ",errorLoadLists.localizedDescription)
        }
    }

}

struct MyListView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: MyListViewController())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct MyListViewController_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
            .edgesIgnoringSafeArea(.all)
    }
}
