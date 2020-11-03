//
//  ProfileViews.swift
//  iDelivery
//
//  Created by mac on 11/3/20.
//

import SwiftUI
class ProfileControllerView: UIViewController {
	//MARK: Properties
	let cardPersonnaleController = CardPersonalView()
	let infoUserTableViewController = InformationOfUserTableViewController()
	let descptionLabel = UILabel.init(text: "complete your profile by adding pricing \nStocke price …etc.\nto helps users get to find you 😎", font: .systemFont(ofSize: 16), numberOfLines: 5, textColor: .label)
	lazy var  addButton : UIButton =  {
		let button = UIButton(type: .system)
		button.setImage(UIImage(systemName: SFSymbols.addInfo), for: .normal)
		button.backgroundColor = .niceBlue
		button.addTarget(self, action: #selector(handlePrestenUpdateProfile), for: .touchUpInside)
		button.constrainWidth(constant: 50)
		button.constrainHeight(constant: 50)
		button.layer.cornerRadius = 5
		button.tintColor = .systemBackground
		return button
	}()
	
	//If User Not Login UI Components
	let deisgn = UIImageView(image : #imageLiteral(resourceName: "Group 109"))
	let loginButton = UIButton(action: "Login", background: .systemRed)
	let registerButton = UIButton(action: "Register", background: .niceBlue)
	
	let haveAccountLabel = UILabel.init(text: "Login to manage your account ", font: .systemFont(ofSize: 16), textColor: .label)
	let registerLabel = UILabel.init(text: "oh! You don’t have an account 🙁,\nyou can create one quickly 😎", font: .systemFont(ofSize: 16),numberOfLines: 2, textColor: .label)
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		createUI()
	}
}

//MARK: create UI
extension  ProfileControllerView {
	fileprivate func createUI() {
		
		
		
		view.backgroundColor = .secondarySystemBackground
		let hStack = HStackView(arrangedSubviews: [descptionLabel,addButton], spacing: 5)
		
		let vStack = VerticalStackView(arrangedSubviews: [cardPersonnaleController.view,hStack,infoUserTableViewController.view], spacing: 20)
		cardPersonnaleController.view.constrainHeight(constant: 180)
		view.addSubview(vStack)
		vStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
		
		//MARK: User not Login
//		view.backgroundColor = .systemBackground
//		let vStackDesign = VerticalStackView(arrangedSubviews: [deisgn,haveAccountLabel,loginButton,registerLabel,registerButton,UIView()], spacing: 10)
//		vStackDesign.alignment = .center
//		registerLabel.textAlignment = .center
//		deisgn.constrainHeight(constant: 350)
//		deisgn.constrainWidth(constant: 350)
//
//		view.addSubview(vStackDesign)
//		vStackDesign.centerInSuperview()
		
		
	}
	
	@objc fileprivate func handlePrestenUpdateProfile() {
		
	}
}



struct ProfileViews: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
		let profileViewController = ProfileControllerView()
		return profileViewController
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
	
	typealias UIViewControllerType = UIViewController
}

struct ProfileViews_Previews: PreviewProvider {
	static var previews: some View {
		ProfileViews()
			.edgesIgnoringSafeArea(.all)
	}
}
