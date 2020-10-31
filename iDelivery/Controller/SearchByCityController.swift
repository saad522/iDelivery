//
//  SearchByCityController.swift
//  iDelivery
//
//  Created by mac on 10/28/20.
//

import SwiftUI

class SearchByCityController: UICollectionViewController {
	
	//MARK: Properties
	private let topCellID 	  = "topCellID"
	private let secondeCellID = "secondeCellID"
	
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpNavigation()
		configuCollectionView()
	}
	
	//--:ComosotionalLayout Configuration
	init() {
		
		let layout = UICollectionViewCompositionalLayout { (numberOfSection, _) -> NSCollectionLayoutSection? in
			if numberOfSection == 0 {
				let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
				item.contentInsets = .init(top: 0, leading: 10, bottom: 12, trailing: 10)
				let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), subitems: [item])
				
				let section = NSCollectionLayoutSection(group: group)
				section.contentInsets.top = 12
				return section
			} else {
				let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
				item.contentInsets = .init(top: 12, leading: 10, bottom: 12, trailing: 10)
				let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(250)), subitems: [item])
				
				let section = NSCollectionLayoutSection(group: group)
				
				return section
			}
			
		}
		
		super.init(collectionViewLayout: layout)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

//MARK: Configuration Of CollectionView
extension SearchByCityController {
	fileprivate func setUpNavigation() {
		navigationItem.title = "Rabat"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	fileprivate func configuCollectionView() {
		collectionView.backgroundColor = .secondarySystemBackground
		collectionView.register(CustomizeButtonsCell.self, forCellWithReuseIdentifier: topCellID)
		collectionView.register(CardUserViewCell.self, forCellWithReuseIdentifier: secondeCellID)
	}
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch indexPath.section {
		case 0:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellID, for: indexPath) as! CustomizeButtonsCell
			return cell
		default:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondeCellID, for: indexPath) as! CardUserViewCell
			return cell
		}
	}
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if indexPath.section == 0 {
//			let filteringController = UIViewController()
//			filteringController.view.backgroundColor = .blue
////			filteringController.modalPresentationStyle = .formSheet
//			present(filteringController, animated: true)
			let slideVC = FiltersView()
			slideVC.modalPresentationStyle = .custom
			slideVC.transitioningDelegate = self
			self.present(slideVC, animated: true)
		} else {
			let detailsControlles = MoreDetailsController()
			detailsControlles.modalPresentationStyle = .fullScreen
			present(detailsControlles, animated: true)
		}
		
		
	}
	
	@objc func showMiracle() {
		let slideVC = FiltersView()
		slideVC.modalPresentationStyle = .custom
		slideVC.transitioningDelegate = self
		self.present(slideVC, animated: true, completion: nil)
	}
}
struct SearchByCityView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
		let searchByCityController = SearchByCityController()
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
