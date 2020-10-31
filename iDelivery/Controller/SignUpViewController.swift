//
//  SignUpViewController.swift
//  iDelivery
//
//  Created by mac on 10/27/20.
//

import SwiftUI

class SignUpViewController: UIViewController {
	//MARK: Properties
	//Title
	let logo = UILabel(text: "iDelevry", font: UIFont(name: "Avenir-Light", size: 36)!, textColor: .label)
	//TextFields
	let fullNameText = UITextField(placholder: "Full-Name")
	let phoneText    = UITextField(placholder: "Phone")
	let passwordText = UITextField(placholder: "Password",isPassword: true)
	let locationText = UITextField(placholder: "City")
	
	//Icons
	let fullNameIcon   = UIImageView(SFSymbols.fullName)
	let phoneIcon      = UIImageView(SFSymbols.phone)
	let passwordIcon   = UIImageView(SFSymbols.password)
	let locationIcone  = UIImageView(SFSymbols.location)

	
	//Image
	let profilePicture : UIImageView = {
		let picture = UIImageView()
		let size : CGFloat = 100
		picture.constrainWidth(constant: size)
		picture.constrainHeight(constant: size)
		picture.layer.cornerRadius = size/2
		picture.layer.borderWidth = 0.5
		picture.layer.borderColor = UIColor.black.cgColor
		return picture
	}()
	
	//Buttons
	let loginUpButton  = UIButton("Aleardy have an account?","Login")
	let signUpButton   = UIButton(title: "SignUp")
	let cameraIcon     = UIButton(SFSymbols.camera)
	let hiddenPassword = UIButton(SFSymbols.closeEye,size: 15,color: .label)
	
	//Separators
	let lineName     = UIView(.systemGray)
	let linePhon     = UIView(.systemGray)
	let linePassword = UIView(.systemGray)
	let lineLocation = UIView(.systemGray)
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpNavigation()
		createUI()
		dismissKeyBoard()
		setActions()
	}
}
extension SignUpViewController {
	fileprivate func setUpNavigation() {
		view.backgroundColor = .secondarySystemBackground
		navigationController?.navigationBar.isHidden = true
	}
	fileprivate func createUI() {
		//LogoView
		loginUpButton.tintColor = .label
		view.addSubview(logo)
		logo.translatesAutoresizingMaskIntoConstraints = false
		logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: -5).isActive = true
		logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		logo.constrainWidth(constant: 140)
		
		//PictureView
		view.addSubview(profilePicture)
		profilePicture.anchor(top: logo.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 25, bottom: 0, right: 0))
		//Camera Icon
		profilePicture.addSubview(cameraIcon)
		cameraIcon.tintColor = .systemGray
		profilePicture.isUserInteractionEnabled = true
		cameraIcon.centerInSuperview()
		
		// StackViews
		// FullName StackView
		let fullNameHS = HStackView(arrangedSubviews: [fullNameIcon,fullNameText,UIView()])
		let fullNameVS = VerticalStackView(arrangedSubviews: [fullNameHS,lineName], spacing: 8)
		
		// Phone StackView
		let phoneHS = HStackView(arrangedSubviews: [phoneIcon,phoneText,UIView()])
		let phoneVS = VerticalStackView(arrangedSubviews: [phoneHS,linePhon], spacing: 8)
		phoneText.keyboardType = .phonePad
		// Password StackView
		let passwordHS = HStackView(arrangedSubviews: [passwordIcon,passwordText,hiddenPassword])
		[passwordIcon,hiddenPassword].forEach({$0.constrainWidth(constant: 25)})
		let passwordVS = VerticalStackView(arrangedSubviews: [passwordHS,linePassword], spacing: 8)
		
		// Location StackView
		let locationHS = HStackView(arrangedSubviews: [locationIcone,locationText,UIView()])
		let locationVS = VerticalStackView(arrangedSubviews: [locationHS,lineLocation], spacing: 8)
		
		// Main Stack
		let mainStack = VerticalStackView(arrangedSubviews: [fullNameVS,phoneVS,passwordVS,locationVS], spacing: 40)
		
		view.addSubview(mainStack)
		mainStack.anchor(top: profilePicture.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 40, left: 25, bottom: 0, right: 25))
		
		//SignUp Button
		view.addSubview(signUpButton)
		signUpButton.anchor(top: mainStack.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 40, left: 25, bottom: 0, right: 25),size: .init(width: 0, height: 50))
		//Login Button
		view.addSubview(loginUpButton)
		loginUpButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 25, bottom: 25, right: 25))
	}
	fileprivate func dismissKeyBoard() {
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
}
extension SignUpViewController {
	fileprivate func setActions() {
		loginUpButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
		hiddenPassword.addTarget(self, action: #selector(handlePassword), for: .touchUpInside)
		signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
	}
	@objc func handleSignUp() {
			let mainTab = MainTabBarController()
			navigationController?.pushViewController(mainTab, animated: true)
		
	}
	@objc fileprivate func handlePassword() {
		if passwordText.isSecureTextEntry == true {
			passwordText.isSecureTextEntry = false
			hiddenPassword.setImage(UIImage(systemName: SFSymbols.openEye), for: .normal)
		} else {
			passwordText.isSecureTextEntry = true
			hiddenPassword.setImage(UIImage(systemName: SFSymbols.closeEye), for: .normal)
		}
	}
	@objc fileprivate func handleLogin() {
		navigationController?.popViewController(animated: true)
		
	}
}



struct SignUpView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
		let signUpViewConntroller = SignUpViewController()
		return UINavigationController(rootViewController: signUpViewConntroller)
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
	
	typealias UIViewControllerType = UIViewController
	
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
		SignUpView()
			.edgesIgnoringSafeArea(.all)
    }
}
