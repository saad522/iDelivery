//
//  MoreDetailsController.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import SwiftUI

class MoreDetailsController: UICollectionViewController {
	
	//MARK: Properties
		//CellIDs
	private let pricingCellID      = "pricingCellID"
	private let prsonaleInfoCellID = "personaleInfoCellId"
	private let toolsCellID		   = "toolsCellID"
	let dismiss = UIButton(SFSymbols.dismiss,size: 20)
	
		//CompostionalLayout
	init() {
		let layout = UICollectionViewCompositionalLayout { (numberOfSection, _) -> NSCollectionLayoutSection? in
			if numberOfSection == 0 {
				let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
				
				let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
				group.contentInsets = .init(top: 0, leading: 5, bottom: 10, trailing: 5)
				let section = NSCollectionLayoutSection(group: group)
				return section
			} else {
				let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)))
				
				let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1)), subitems: [item])
				group.contentInsets = .init(top: 0, leading: 5, bottom: 5, trailing: 5)
				let section = NSCollectionLayoutSection(group: group)
				return section
			}
		}
		
		super.init(collectionViewLayout: layout)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.backgroundColor = .secondarySystemBackground
		configCollectionView()
	}
}
extension MoreDetailsController {
	fileprivate func configCollectionView() {
		collectionView.register(PricingInformationCard.self, forCellWithReuseIdentifier: pricingCellID)
		collectionView.register(PersonaleInfoCell.self, forCellWithReuseIdentifier: prsonaleInfoCellID)
		collectionView.register(ToolsCardCell.self, forCellWithReuseIdentifier: toolsCellID)
		view.addSubview(dismiss)
		dismiss.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 35, left: 0, bottom: 0, right: 15))
		dismiss.addTarget(self, action: #selector(handelDismiss), for: .touchUpInside)
	}
	@objc func handelDismiss() {
		dismiss(animated: true)
	}
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch indexPath.item {
		case 0:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: prsonaleInfoCellID, for: indexPath)
			return cell
		case 1:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pricingCellID, for: indexPath) as! PricingInformationCard
			return cell
			
		default:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toolsCellID, for: indexPath) as! ToolsCardCell
			return cell
		}
	}
}
struct MoreDetails: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
		let moreDetailsController = MoreDetailsController()
		return moreDetailsController
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
	}
	
	typealias UIViewControllerType = UIViewController
	
	
}

struct MoreDetailsController_Previews: PreviewProvider {
	static var previews: some View {
		MoreDetails()
			.edgesIgnoringSafeArea(.all)
	}
}















//	let segment : UISegmentedControl = {
//		let se = UISegmentedControl()
//		se.insertSegment(with: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.currency)!, string: "Pricing", color: .label, imageAlignment: 0, segFont: .systemFont(ofSize: 15)) , at: 0, animated: false)
//
//
//		se.insertSegment(with: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.valise)!, string: "Tools", color: .label, imageAlignment: 0, segFont: .systemFont(ofSize: 15)) , at: 1, animated: false)
//
//		se.insertSegment(with: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.members)!, string: "Memebers", color: .label, imageAlignment: 0, segFont: .systemFont(ofSize: 15)) , at: 2, animated: false)
//
//		se.selectedSegmentIndex = 0
//		return se
//	}()
