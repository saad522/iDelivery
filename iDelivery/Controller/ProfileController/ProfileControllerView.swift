//
//  ProfileViews.swift
//  iDelivery
//
//  Created by mac on 11/3/20.
//

import SwiftUI
import Firebase

class ProfileControllerView: UIViewController {
	//MARK: Properties
	let cardPersonnaleController = CardPersonalView()
	let infoUserTableViewController = InformationOfUserTableViewController()
	let descptionLabel = UILabel.init(text: "complete your profile by adding pricing \nStocke price …etc.\n to helps users get to find you 😎", font: .systemFont(ofSize: 14), numberOfLines: 7, textColor: .label)
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
    let logoutButton = UIButton(action: "LogOut", background: .systemRed)
	//If User Not Login UI Components
	let deisgn = UIImageView(image : #imageLiteral(resourceName: "Group 109"))
	let loginButton = UIButton(action: "Login", background: .systemRed)
//	let registerButton = UIButton(action: "Register", background: .niceBlue)
	
	let haveAccountLabel = UILabel.init(text: "Login to manage your account ", font: .systemFont(ofSize: 16), textColor: .label)

	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
        checkIfUserLoggedIn()
        fetchUserData()
        setAction()
//        API.shared.updateUserData()
	}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfUserLoggedIn()
        fetchUserData()
    }
}

//MARK: setupFirebase
extension ProfileControllerView {
    fileprivate func signOut() {
        do {
            try Auth.auth().signOut()
            checkIfUserLoggedIn()
        } catch let signOutError {
            print("Having Trobble with SignOut the usr", separator: "resons:", terminator: "\(signOutError)")
        }
    }
    func setAction() {
        logoutButton.addTarget(self, action: #selector(handelLogout), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
    }
    
    @objc func handelLogout() {
        signOut()
    }
    @objc func handelLogin() {
        let loginController = LoginViewController()
        loginController.prfileViewController = self
        let controller = UINavigationController(rootViewController: loginController)
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true)
    }
     func fetchUserData() {
        API.shared.fetchUserData { (user, error) in
            if let error = error {
                print("Failed To Load Data 👎🏻 reason ",error.localizedDescription)
                return
            }
            self.cardPersonnaleController.user = user
            self.infoUserTableViewController.user = user
        }
    }
}
//MARK: create UI
extension  ProfileControllerView {
     func checkIfUserLoggedIn() {
        
        let vStackDesign = VerticalStackView(arrangedSubviews: [deisgn,haveAccountLabel,loginButton,UIView()], spacing: 10)
        
        let vStack = VerticalStackView(arrangedSubviews: [cardPersonnaleController.view,infoUserTableViewController.view,HStackView(arrangedSubviews: [descptionLabel,addButton], spacing: 5),logoutButton,UIView()], spacing: 20)
        
        if Auth.auth().currentUser?.uid == nil {
            //MARK: User not Login
            view.backgroundColor = .systemBackground
            vStackDesign.alignment = .center
            deisgn.constrainHeight(constant: 200)
            deisgn.constrainWidth(constant: 200)
            view.addSubview(vStackDesign)
            vStackDesign.centerInSuperview()
            vStack.removeFromSuperview()
        } else {
            view.backgroundColor = .secondarySystemBackground
            cardPersonnaleController.view.constrainHeight(constant: 180)
            view.addSubview(vStack)
            vStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
            vStackDesign.removeFromSuperview()
        }
    }
//	fileprivate func createUI() {
//
//
//
//	}
//    func userNotLoggedUI() {
//
//    }
	@objc fileprivate func handlePrestenUpdateProfile() {
		let editeProfileViwController = EditeProfileViewController()
        editeProfileViwController.profileViewController = self
        let controller = UINavigationController(rootViewController: editeProfileViwController)
		present(controller, animated: true)
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
