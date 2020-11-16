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
    // dependency injection constructor
    
    
    
	private let topCellID 	  = "topCellID"
	private let secondeCellID = "secondeCellID"
    var users = [User]()
    var forReload = [User]()
    
    let imageDesign = UIImageView(image : #imageLiteral(resourceName: "undraw_empty_xct9"))
    let message = UILabel.init(text: "We didn't find anyone here", font: .systemFont(ofSize: 16, weight: .light))
    
	
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpNavigation()
		configuCollectionView()
		menus()
        createDesign()
        fectch()
	}
	
	//--ComosotionalLayout Configuration
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
	
	fileprivate func menus() {
		let filters = UIMenu(title: "", children: [
								UIAction(title: "Filters", image: UIImage(systemName: SFSymbols.filter), handler: handleFilters),
								UIAction(title: "Sorts", image: UIImage(systemName: SFSymbols.sort), handler: handleSort),
								UIAction(title: "Reloads", image: UIImage(systemName: SFSymbols.reload), handler: handleReload)])
		let barItem = UIBarButtonItem(title: "", image: #imageLiteral(resourceName: "icons8-filter-100").withTintColor(.label).withRenderingMode(.alwaysOriginal), menu: filters)
		navigationItem.rightBarButtonItem = barItem
		
	}
}

//MARK: setup Firebase
extension SearchByCityController {

    func fectch() {
        API.shared.fetchUsersData(city: city) { (user, error)   in
            if let error = error {
                print("We could not fetch users data reason ",error.localizedDescription)
                return
            }
            self.users = user ?? []
            self.forReload = user ?? []
//            self.users.forEach({print("\($0.fullName) \($0.price), \($0.city) \($0.retruns)")})
//            user?.forEach({print($0.price)})
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

  
}

//MARK: Configuration Of CollectionView
extension SearchByCityController {
    fileprivate func createDesign() {
        view.addSubview(imageDesign)
        imageDesign.centerInSuperview(size: .init(width: 284, height: 223))
        view.addSubview(message)
        message.translatesAutoresizingMaskIntoConstraints = false
        message.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        message.topAnchor.constraint(equalTo: imageDesign.bottomAnchor).isActive = true
    }
	fileprivate func setUpNavigation() {
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	fileprivate func configuCollectionView() {
		collectionView.backgroundColor = .secondarySystemBackground
		collectionView.register(CardUserViewCell.self, forCellWithReuseIdentifier: secondeCellID)
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        [imageDesign,message].forEach({$0.isHidden = users.count != 0 })
        return users.count
	}
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondeCellID, for: indexPath) as! CardUserViewCell
        let user = users[indexPath.item]
        cell.user = user
        return cell
        
    }
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let user = users[indexPath.item]
			let detailsControlles = MoreDetailsController(user: user)
			detailsControlles.modalPresentationStyle = .fullScreen
			present(detailsControlles, animated: true)
	}
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
