//
//  SearchViewController.swift
//  iDelivery
//
//  Created by mac on 10/28/20.
//

import SwiftUI

class SearchViewController: UICollectionViewController {
	//MARK: Properties
	private let cellID = "cellID"
	let searchController = UISearchController(searchResultsController: nil)
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpNavigation()
		configuerCollectionView()
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
//MARK: setUp NavigationController
extension SearchViewController : UISearchBarDelegate {
	fileprivate func setUpNavigation() {
		navigationItem.title = "Search by Cities"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		searchController.searchBar.delegate = self
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
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let searchByCityController = SearchByCityController()
		navigationController?.pushViewController(searchByCityController, animated: true)
		
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
