//
//  MoreDetailsController.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import SwiftUI

class MoreDetailsController: UICollectionViewController {
	
	//MARK: Properties
		//Pricing
		//Tools
		//Memebers
		//IDs
	private let pricingCellID = "pricingCellID"
	private let prsonaleInfoCellID = "personaleInfoCellId"
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
		view.addSubview(dismiss)
		dismiss.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 35, left: 0, bottom: 0, right: 35))
		dismiss.addTarget(self, action: #selector(handelDismiss), for: .touchUpInside)
	}
	@objc func handelDismiss() {
		dismiss(animated: true)
	}
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
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
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pricingCellID, for: indexPath) as! PricingInformationCard
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














//extension UIImage {
//
//class func textEmbededImage(image: UIImage, string: String, color:UIColor, imageAlignment: Int = 0, segFont: UIFont? = nil) -> UIImage {
//	let font = segFont ?? UIFont.systemFont(ofSize: 16.0)
//	let expectedTextSize: CGSize = (string as String).size(withAttributes: [NSAttributedString.Key.font: font])
//	let width: CGFloat = expectedTextSize.width + image.size.width + 5.0
//	let height: CGFloat = max(expectedTextSize.height, image.size.width)
//	let size: CGSize = CGSize(width: width, height: height)
//	UIGraphicsBeginImageContextWithOptions(size, false, 0)
//	let context: CGContext = UIGraphicsGetCurrentContext()!
//	context.setFillColor(color.cgColor)
//	let fontTopPosition: CGFloat = (height - expectedTextSize.height) / 2.0
//	let textOrigin: CGFloat = (imageAlignment == 0) ? image.size.width + 5 : 0
//	let textPoint: CGPoint = CGPoint.init(x: textOrigin, y: fontTopPosition)
//	string.draw(at: textPoint, withAttributes: [NSAttributedString.Key.font: font])
//	let flipVertical: CGAffineTransform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height)
//	context.concatenate(flipVertical)
//	let alignment: CGFloat =  (imageAlignment == 0) ? 0.0 : expectedTextSize.width + 5.0
//	context.draw(image.cgImage!, in: CGRect.init(x: alignment, y: ((height - image.size.height) / 2.0), width: image.size.width, height: image.size.height))
//	let newImage = UIGraphicsGetImageFromCurrentImageContext()
////	UIGraphicsEndImageContext()
//
//	return newImage!
//}
//}
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
