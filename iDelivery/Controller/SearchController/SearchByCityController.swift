//
//  SearchByCityController.swift
//  iDelivery
//
//  Created by mac on 10/28/20.
//

import SwiftUI
import SDWebImage
import FirebaseFirestore

class SearchByCityController: UICollectionViewController {
	
	//MARK: Properties
  
    fileprivate let city: String
    
	private let topCellID 	  = "topCellID"
	private let secondeCellID = "secondeCellID"
    
    var users     = [User]()
    var forReload = [User]()
    
    let imageDesign = UIImageView(image : #imageLiteral(resourceName: "undraw_empty_xct9"))
    let message     = UILabel.init(text: "We didn't find anyone here", font: .systemFont(ofSize: 16, weight: .light))
    
    var dataSource: UICollectionViewDiffableDataSource<Section, User>!

    enum Section: CaseIterable {
        case main
    }
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configuCollectionView()

	}

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        setFontAndColor()
    }
    
	//--ComosotionalLayout Configuration with dependency injection constructor
	init(city: String?) {
		let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
		item.contentInsets = .init(top: 12, leading: 10, bottom: 12, trailing: 10)
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(250)), subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		let layout = UICollectionViewCompositionalLayout(section: section)
        self.city = city ?? "Casablnca"
		super.init(collectionViewLayout: layout)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}

//MARK: setup Firebase with DiffabledataSource
extension SearchByCityController {
    func performQuery() {
        API.shared.fetchUsersData(city: city) { (user, error)   in
            if let error = error {
                print("We could not fetch users data reason ",error.localizedDescription)
                return
            }
            var snapshot = self.dataSource.snapshot()
            snapshot.appendSections([.main])
            self.users = user ?? []
            self.forReload = user ?? []
            [self.imageDesign,self.message].forEach({$0.isHidden = self.users.count != 0 })
            snapshot.appendItems(self.users)
            self.dataSource.apply(snapshot)
            
        }
    }
    
}

//MARK: Configuration Of CollectionView & UI
extension SearchByCityController {
    fileprivate func menus(with color : UIColor = .niceBlue) {
        let filters = UIMenu(title: "", children: [
                                UIAction(title: "Filters", image: UIImage(systemName: SFSymbols.filter), handler: handleFilters),
                                UIAction(title: "Sorts", image: UIImage(systemName: SFSymbols.sort), handler: handleSort),
                                UIAction(title: "Reloads", image: UIImage(systemName: SFSymbols.reload), handler: handleReload)])
        let barItem = UIBarButtonItem(title: "", image: UIImage(systemName: SFSymbols.setFiltering)!.withTintColor(color).withRenderingMode(.alwaysOriginal), menu: filters)
        navigationItem.rightBarButtonItem = barItem
        
    }
    fileprivate func setFontAndColor() {
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
        navigationController?.navigationBar.titleTextAttributes = [.font : UIFont(name: fontName, size: 25)!,.foregroundColor: color]
        message.font = UIFont(name: fontName, size: 16)
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont(name: fontName, size: 35)!]
        menus(with: color)
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
    fileprivate func createDesign() {
        view.addSubview(imageDesign)
        imageDesign.centerInSuperview(size: .init(width: 284, height: 223))
        view.addSubview(message)
        message.translatesAutoresizingMaskIntoConstraints = false
        message.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        message.topAnchor.constraint(equalTo: imageDesign.bottomAnchor).isActive = true
    }
	fileprivate func configuCollectionView() {
        navigationController?.navigationBar.prefersLargeTitles = true
		collectionView.backgroundColor = .secondarySystemBackground
		collectionView.register(CardUserViewCell.self, forCellWithReuseIdentifier: secondeCellID)
        configureDataSource()
        performQuery()
        menus()
        createDesign()
	}
	

    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CardUserViewCell, User> { (cell, indexPath, _) in
            // Populate the cell with our item description.
            let user = self.users[indexPath.item]
            cell.user = user
            let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
            cell.setFonts(fontName: fontName)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: User) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
    }

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let user = users[indexPath.item]
			let detailsControlles = MoreDetailsController(user: user)
			detailsControlles.modalPresentationStyle = .fullScreen
			present(detailsControlles, animated: true)
	}


}
//MARK: Filters Buttons
extension SearchByCityController {
    func handleFilters(action: UIAction) {
        let slideVC = FiltersView(users: users)
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.searchConntroller = self
        self.present(slideVC, animated: true)
    }
    func handleSort(action: UIAction) {
        let slideVC = SortsView(users: users)
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.searchConntroller = self
        self.present(slideVC, animated: true)
    }
    func handleReload(action: UIAction) {
        self.users = forReload
        collectionView.reloadData()
    }
}
struct SearchByCityView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
		let searchByCityController = SearchByCityController(city: nil)
		return UINavigationController(rootViewController: searchByCityController)
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
	
	typealias UIViewControllerType = UIViewController
	
	
}

struct SearchByCityController_Previews: PreviewProvider {
	static var previews: some View {
		SearchByCityView()
			.edgesIgnoringSafeArea(.all)
	}
}

extension SearchByCityController: UIViewControllerTransitioningDelegate {
	func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		PresentationController(presentedViewController: presented, presenting: presenting)
	}
}
