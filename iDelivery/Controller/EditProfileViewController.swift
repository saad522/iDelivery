//
//  EditProfileViewController.swift
//  iDelivery
//
//  Created by mac on 11/9/20.
//

import SwiftUI


class EditeProfileViewController: UIViewController {
	//MARK:Properties
	//TextFields
	let priceText  = UITextField(placholder: "Order Price  30 MAD")
	let retrunText = UITextField(placholder: "Retrun Price 10 MAD")
	let stockText  = UITextField(placholder: "Stcoke Price 15 MAD")
	
	let segmentedController : UISegmentedControl = {
		let carImage = UIImage(named: "car")?.resized(to: CGSize(width: 25, height: 25))
		let motorImage = UIImage(named: "motorcycle")?.resized(to: CGSize(width: 25, height: 25))
		
		let segment = UISegmentedControl(items: [UIImage.textEmbededImage(image: motorImage!, string: "Motorcycle", color: .label),UIImage.textEmbededImage(image: carImage!, string: "Car", color: .label)])
		segment.selectedSegmentIndex = 0
		return segment
	}()
	
	//Icons
	private let priceIcon     = UIImageView(SFSymbols.currency)
	private let transportIcon = UIImageView(SFSymbols.valise)
	private let retrunIcon    = UIImageView(SFSymbols.currency)
	private let stockIcone    = UIImageView(SFSymbols.package)
	
	//Separators
	private let linePrice     = UIView(.systemGray)
	private let lineRetrun    = UIView(.systemGray)
	private let lineTransport = UIView(.systemGray)
	private let lineStock     = UIView(.systemGray)
	
	//Buttons
	private let updateButton = UIButton.init(title: "Update", .niceBlue, .systemBackground, 36)
	
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		creatUI()
	}
}

//MARK: Create UI
extension EditeProfileViewController {
	fileprivate func creatUI() {
		view.backgroundColor = .systemBackground
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancle", style: .done, target: self, action: #selector(handleCancel))
		
		let hStackPrice = HStackView(arrangedSubviews: [priceIcon,priceText,UIView()], spacing: 5)
		let vStackPrice = VerticalStackView(arrangedSubviews: [hStackPrice,linePrice], spacing: 5)

		let hStackTransport = HStackView(arrangedSubviews: [transportIcon,segmentedController,UIView()], spacing: 5)
		
		let vStackTransport = VerticalStackView(arrangedSubviews: [hStackTransport,lineTransport], spacing: 5)
		
		let hStackRetrun = HStackView(arrangedSubviews: [retrunIcon,retrunText,UIView()], spacing: 5)
		
		let vStackRetrun = VerticalStackView(arrangedSubviews: [hStackRetrun,lineRetrun], spacing: 5)
		
		let hStackStck = HStackView(arrangedSubviews: [stockIcone,stockText,UIView()], spacing: 5)
		
		let vStackStock = VerticalStackView(arrangedSubviews: [hStackStck,lineStock], spacing: 5)
		let stack = VerticalStackView(arrangedSubviews: [vStackPrice,vStackRetrun,vStackStock,vStackTransport], spacing: 40)
		
		view.addSubview(stack)
		stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 25, left: 25, bottom: 0, right: 25))
		view.addSubview(updateButton)
		updateButton.anchor(top: stack.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 35, left: 25, bottom: 0, right: 25))
//		view.addSubview(segmentedController)
//		segmentedController.centerInSuperview()
	}
	
	
	@objc func handleCancel(){
		dismiss(animated: true, completion: nil)
	}
}


struct EditeProfileViews: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
		let profileViewController = UINavigationController(rootViewController: EditeProfileViewController())
		return profileViewController
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
	
	typealias UIViewControllerType = UIViewController
}

struct EditeProfileViews_Previews: PreviewProvider {
	static var previews: some View {
		EditeProfileViews()
			.edgesIgnoringSafeArea(.all)
	}
}
