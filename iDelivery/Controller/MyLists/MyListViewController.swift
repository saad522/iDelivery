//
//  MyListViewController.swift
//  iDelivery
//
//  Created by mac on 11/27/20.
//

import SwiftUI

class MyListViewController: UICollectionViewController {
    //MARK: Properties
    private let cellID = "cellID"
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
        creatUI()
    }

    fileprivate func cellRefistration() {
        collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    fileprivate func creatUI() {
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ListViewCell
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
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
