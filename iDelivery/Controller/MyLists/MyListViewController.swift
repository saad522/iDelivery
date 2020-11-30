//
//  MyListViewController.swift
//  iDelivery
//
//  Created by mac on 11/27/20.
//

import SwiftUI

struct List : Hashable {
    
    let id    = UUID().uuidString
    let color : UIColor
    let name  : String
    
    static func == (lhs: List, rhs: List) -> Bool {
        lhs.id == rhs.id
    }
}
class MyListViewController: UICollectionViewController {
 
    
    //MARK: Properties
    private let cellID = "cellID"
    let listImage = UIImageView(image : #imageLiteral(resourceName: "undraw_No_data_re_kwbl"))
    let listTitle = UILabel.init(text: "Create your own Lists 😎", font: .systemFont(ofSize: 35, weight: .semibold), numberOfLines: 2)
    
    enum Section {
        case main
    }
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, List> = .init(collectionView: collectionView) { (collection, indexPath, list) -> UICollectionViewCell? in
        let cell = collection.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! ListViewCell
        cell.circle.backgroundColor = list.color
        cell.name.text = list.name
        return cell
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
}

//MARK: setup Core-Data
extension MyListViewController {
    @objc func handleAddNewList() {
        print("Presnting AddListViewController...")
        let addListViewController = AddListViewController()
        addListViewController.didAddList = { name, color in
            let newList = List(color: color, name: name)
            var snapshot = self.diffableDataSource.snapshot()
            snapshot.appendItems([newList])
            self.diffableDataSource.apply(snapshot)
            self.dismiss(animated: true)
        }
        
        present(addListViewController, animated: true)
    }
}
//MARK: Configure CollectionView
extension MyListViewController {
    fileprivate func setUpNvigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My Lists"
        collectionView.backgroundColor = .secondarySystemBackground
        let barItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.addList)?.withTintColor(.label).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddNewList))
        navigationItem.rightBarButtonItem = barItem
        cellRefistration()
        setupSource()
//        creatUI()
    }
    fileprivate func creatUI() {
        let vStack = VerticalStackView(arrangedSubviews: [listImage,listTitle], spacing: 5)
        vStack.alignment = .center
        listImage.constrainWidth(constant: 300)
        listImage.constrainHeight(constant: 300)
        collectionView.addSubview(vStack)
        vStack.anchor(top: collectionView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listDeatail = ListDetailViewControlller(style: .insetGrouped)
        navigationController?.pushViewController(listDeatail, animated: true)
        print("HOLO...")
    }
    fileprivate func cellRefistration() {
        collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: cellID)
    }
 
    fileprivate func setupSource() {
        collectionView.dataSource = diffableDataSource
        var snapshot = diffableDataSource.snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems([
            List(color: .systemGreen, name: "Casablanca List"),
            List(color: .systemBlue, name: "Fes List"),
            List(color: .systemOrange, name: "Squad List"),
            List(color: .systemPink, name: "top 10 "),
            List(color: .systemYellow, name: "Tangier List"),
        ], toSection: .main)
        diffableDataSource.apply(snapshot)
        
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
