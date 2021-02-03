//
//  LoginViewController.swift
//  iDelivery
//
//  Created by mac on 10/27/20.
//

import SwiftUI
import Firebase

class LoginViewController: UIViewController {
	
	
	//MARK: Properties
    var prfileViewController : ProfileControllerView?
    
	//Titles
	let logo       = UILabel(text: "iDelevry", font: UIFont(name: "Avenir-Light", size: 36)!, textColor: .label)
    let loginlabel = UILabel.init(text: "Login".localized, font: UIFont(name: "Avenir-Light", size: 36)!, textColor: .label)
	
	//Icons
	let emailIcon     = UIImageView(SFSymbols.email)
	let passwordIcon  = UIImageView(SFSymbols.password)
	
	
	//TextFields
    let emailText    = UITextField(placholder: "Email".localized)
    let passwordText = UITextField(placholder: "Password".localized,isPassword: true)

	
	//Containers
	let emailContainer     = UIView(shadowOpacity: 0.4)
	let passwordContainer  = UIView(shadowOpacity: 0.4)
	
	
	//Buttons
    let loginButton    = UIButton(title: "Login".localized)
    var skipButton     = UIButton()
	var signUpButton   = UIButton()
	let hiddenPassword = UIButton(SFSymbols.closeEye,size: 15,color: .label)
    
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpNavigationBar()
		createUI()
		dismissKeyBoard()
		setActions()
	}

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFontAndColor()
 
    }
}

//MARK: Create Login  UI
extension LoginViewController {
	fileprivate func setUpNavigationBar() {
		navigationController?.navigationBar.isHidden = true
		view.backgroundColor = .secondarySystemBackground
	}
	fileprivate func createUI() {
        skipButton = UIButton("I'm just a Visitor!".localized,"Skip".localized)
        signUpButton = UIButton("Don't have an account?".localized,"Register".localized)
		[skipButton,signUpButton].forEach({$0.tintColor = .label})

        let vStack = VerticalStackView(arrangedSubviews: [logo,loginlabel], spacing: 65)
        vStack.alignment = .center
		let emailStack = HStackView(arrangedSubviews: [emailIcon,emailText,UIView()])
		emailContainer.addSubview(emailStack)
		emailStack.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 0))
		let passwordStack = HStackView(arrangedSubviews: [passwordIcon,passwordText,hiddenPassword])
		[passwordIcon,hiddenPassword].forEach({$0.constrainWidth(constant: 25)})
		
		passwordContainer.addSubview(passwordStack)
		passwordStack.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
		
		let vStackContainer = VerticalStackView(arrangedSubviews: [vStack,emailContainer,passwordContainer,loginButton,skipButton], spacing: 30)
		view.addSubview(vStackContainer)
		
		
		[emailContainer,passwordContainer,loginButton].forEach({$0.constrainHeight(constant: 50)})
		
        vStackContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 25, bottom: 0, right: 25))
		view.addSubview(signUpButton)
		signUpButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 25, bottom: 25, right: 25))
	}
	fileprivate func dismissKeyBoard() {
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
    fileprivate func setFontAndColor() {
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
        navigationController?.navigationBar.tintColor = color
        tabBarController?.tabBar.tintColor = color
        loginButton.backgroundColor = color
        loginButton.titleLabel?.font = UIFont(name: fontName, size: 36)
        [loginlabel,logo].forEach({$0.font = UIFont(name: fontName, size: 36)})
        
        [emailText,passwordText].forEach({$0.font = UIFont(name: fontName, size: 19)})
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
}
//MARK: Set Actions & Auth with Firebase

extension LoginViewController {
	fileprivate func setActions() {
		signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
		hiddenPassword.addTarget(self, action: #selector(handlePassword), for: .touchUpInside)
		skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
		loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
	}
    
    @objc func handleLogin() {
        let logginAlert =  Alert.alerts(title: "Logging...")
       
        guard let email    = emailText.text else { return  }
        guard let password = passwordText.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed to Login user 👎🏾 reason :",error.localizedDescription)
                Alert.showInteractiveAlert(self, with: "Invalid Information 👎🏾", and: "\(error.localizedDescription)")
                return
            }
           
            self.present(logginAlert, animated: true)
            print("User is logged 👍🏿 ")
            self.prfileViewController?.fetchUserData()
            self.prfileViewController?.checkIfUserLoggedIn()
            logginAlert.dismiss(animated: true) {
                self.dismiss(animated: true)
            }
           
        }
	}
	@objc func handleSkip() {
        self.dismiss(animated: true)
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
	@objc fileprivate func handleSignUp() {
		let signUpViewController = SignUpViewController()
        signUpViewController.prfileViewController = prfileViewController
		navigationController?.pushViewController(signUpViewController, animated: true)

		
	}
}

struct LoginView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
		let loginViewController = LoginViewController()
		return UINavigationController(rootViewController: loginViewController)
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
	

	
	typealias UIViewControllerType = UIViewController
	
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
			.edgesIgnoringSafeArea(.all)
    }
}

//self.backgroundView?.layer.shadowOpacity = 0.1
//self.backgroundView?.layer.shadowRadius = 10
//self.backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
//self.backgroundView?.layer.shouldRasterize = true
