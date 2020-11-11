//
//  SearchViewController.swift
//  iDelivery
//
//  Created by mac on 10/28/20.
//

import SwiftUI
import Firebase

class SearchViewController: UICollectionViewController {
	//MARK: Properties
	private let cellID = "cellID"
	let searchController = UISearchController(searchResultsController: nil)
	var nameFilter: String?
	var dataSource: UICollectionViewDiffableDataSource<Section, MountainsController.Mountain>!

	enum Section: CaseIterable {
		case main
	}
	let mountainsController = MountainsController()
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
        checkIfUserLoggedIn()
//        signOut()
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchViewController()
        
    }
	//MARK: ComposotionalLayout
	init() {
		let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
		item.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		
		let layout = UICollectionViewCompositionalLayout(section: section)
		
		super.init(collectionViewLayout: layout)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
//MARK: Configure Firebase
extension SearchViewController {
    fileprivate func checkIfUserLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            let loginViewScreen = LoginViewController()
            let controller = UINavigationController(rootViewController: loginViewScreen)
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true)
        } else {
            setupSearchViewController()
        }
    }
    fileprivate func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError {
            print("Having Trobble with SignOut the usr", separator: "resons:", terminator: "\(signOutError)")
        }
    }
}
//MARK: Configure CollectionView
extension SearchViewController {
	/// - Tag: SearchViewControllerDataSource
	func configureDataSource() {
		
		let cellRegistration = UICollectionView.CellRegistration
		<SearchViewCell, MountainsController.Mountain> { (cell, indexPath, mountain) in
			// Populate the cell with our item description.
			cell.name.text = mountain.name
		}
		
		dataSource = UICollectionViewDiffableDataSource<Section, MountainsController.Mountain>(collectionView: collectionView) {
			(collectionView: UICollectionView, indexPath: IndexPath, identifier: MountainsController.Mountain) -> UICollectionViewCell? in
			// Return the cell.
			
			return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
		}
	}
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let object = dataSource.itemIdentifier(for: indexPath)
		let searchByCitiesController = SearchByCityController(city: object?.name ?? "Casablnca")
		navigationController?.pushViewController(searchByCitiesController, animated: true)
		searchByCitiesController.navigationItem.title = object?.name ?? "Casablnca"
	}
	/// - Tag: MountainsPerformQuery
	func performQuery(with filter: String?) {
		let mountains = mountainsController.filteredMountains(with: filter).sorted { $0.name < $1.name }
			
		var snapshot = NSDiffableDataSourceSnapshot<Section, MountainsController.Mountain>()
		snapshot.appendSections([.main])
		snapshot.appendItems(mountains)
		
		dataSource.apply(snapshot, animatingDifferences: true)
	}
}


//MARK: setUp NavigationController
extension SearchViewController : UISearchBarDelegate {
	fileprivate func setUpNavigation() {
		navigationItem.title = "Search by Cities"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		searchController.searchBar.delegate = self
	}
    
    func setupSearchViewController() {
        setUpNavigation()
        configuerCollectionView()
        configureDataSource()
        performQuery(with: nil)
    }
}


//MARK: configure ColllectionViewController
extension SearchViewController  {
	
	fileprivate func configuerCollectionView() {
		collectionView.backgroundColor = .secondarySystemBackground
		collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: cellID)
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 45
	}
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchViewCell

		return cell
	}
	
	
}
extension SearchViewController {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		performQuery(with: searchText)
	}
}


struct SearchView : UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
		let searchViewController = SearchViewController()
		return UINavigationController(rootViewController: searchViewController)
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
	
	typealias UIViewControllerType = UIViewController
	
    
}

struct SearchViewController_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
			.edgesIgnoringSafeArea(.all)
    }
}
