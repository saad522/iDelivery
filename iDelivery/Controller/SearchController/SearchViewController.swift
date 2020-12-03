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
    var user : User!
    
	let searchController = UISearchController(searchResultsController: nil)
	var nameFilter: String?
	var dataSource: UICollectionViewDiffableDataSource<Section, MountainsController.Mountain>!
    //Profile Picture
    lazy var profileButton : UIButton = {
        let button = UIButton(type : .custom)
        button.setImage(#imageLiteral(resourceName: "icons8-administrator-male-100").withTintColor(.label).withRenderingMode(.alwaysOriginal), for: .normal)
        let imageSize : CGFloat = 30
        button.constrainWidth(constant: imageSize)
        button.constrainHeight(constant: imageSize)
        button.layer.cornerRadius = imageSize / 2
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handelProfileButton), for: .touchUpInside)
        return button
    }()
	enum Section: CaseIterable {
		case main
	}
    @objc fileprivate func handelProfileButton() {
        let profileViewController = ProfileControllerView()
        if user != nil {
            profileViewController.cardPersonnaleController.user = user
            profileViewController.infoUserTableViewController.user = user
        }
        present(profileViewController, animated: true)
    }
	let mountainsController = MountainsController()
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
        checkIfUserLoggedIn()
        fetchUserData()
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchViewController()
        fetchUserData()
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"

        navigationController?.navigationBar.titleTextAttributes = [.font : UIFont(name: fontName, size: 25)!,.foregroundColor: color]
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont(name: fontName, size: 35)! ]
        navigationController?.navigationBar.tintColor = color
        tabBarController?.tabBar.tintColor = color
        let index =  UserDefaults.standard.integer(forKey: Keys.intKey)
        if  index == 0 {
            print(index)
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        } else if index == 1 {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
            print(index)
        }
        
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
}
//MARK: Configure CollectionView
extension SearchViewController {
	/// - Tag: SearchViewControllerDataSource
	func configureDataSource() {
		
		let cellRegistration = UICollectionView.CellRegistration
		<SearchViewCell, MountainsController.Mountain> { (cell, indexPath, mountain) in
			// Populate the cell with our item description.
			cell.name.text = mountain.name
            let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
            cell.name.font = UIFont(name: fontName, size: 16)
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
        collectionView.backgroundColor = .secondarySystemBackground
        let barItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = barItem
	}
    func fetchUserData() {
       API.shared.fetchUserData { (user, error) in
           if let error = error {
               print("Failed To Load Data 👎🏻 reason ",error.localizedDescription)
               return
           }
        self.user = user
        guard let image = user?.profileImage else {return}
        self.profileButton.sd_setImage(with: URL(string: image), for: .normal)
       }
   }
    func setupSearchViewController() {
        setUpNavigation()
        configureDataSource()
        performQuery(with: nil)
        
    }
    
}


//MARK: configure ColllectionViewController
extension SearchViewController  {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 45
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
