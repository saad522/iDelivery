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
	let cardPersonnaleController    = CardPersonalView()
	let infoUserTableViewController = InformationOfUserTableViewController()
    var user : User!
    
    let descptionLabel = UILabel(text: "complete your profile by adding pricing Stocke price...\nto helps users get to find you 😎",numberOfLines: 7)
    
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
	let deisgn           = UIImageView(image : #imageLiteral(resourceName: "Group 109"))
    let loginButton      = UIButton(action: "Login".localized, background: .niceBlue)
    let haveAccountLabel = UILabel(text: "Login to manage your account".localized)

	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
        checkIfUserLoggedIn()
        fetchUserData()
        setAction()
        setNavigation()
	}

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfUserLoggedIn()
        fetchUserData()
        setFontAndColor()
        
    }
}

//MARK: setupFirebase
extension ProfileControllerView {
    fileprivate func setNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancle".localized, style: .done, target: self, action: #selector(handleCancel))
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    fileprivate func signOut() {
        do {
            try Auth.auth().signOut()
            checkIfUserLoggedIn()
        } catch let signOutError {
            print("Having Trobble with SignOut the usr", separator: "resons:", terminator: "\(signOutError)")
        }
    }
    func setAction() {
        loginButton.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
        cardPersonnaleController.editProfileButtons.addTarget(self, action: #selector(handlePrestenEditPersonnaleInfo), for: .touchUpInside)
        cardPersonnaleController.editPictureButtons.addTarget(self, action: #selector(handlePrestenEditPicture), for: .touchUpInside)
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
            self.user = user
            self.cardPersonnaleController.user = user
            self.infoUserTableViewController.user = user
        }
    }
}
//MARK: create UI
extension  ProfileControllerView {
     func checkIfUserLoggedIn() {
        let vStackDesign = VerticalStackView(arrangedSubviews: [deisgn,haveAccountLabel,loginButton,UIView()], spacing: 10)
        
        let vStack = VerticalStackView(arrangedSubviews: [cardPersonnaleController.view,infoUserTableViewController.view,HStackView(arrangedSubviews: [descptionLabel,addButton], spacing: 5),UIView()], spacing: 15)
        
        if Auth.auth().currentUser?.uid == nil {
//            MARK: User not Login
            view.backgroundColor = .systemBackground
            vStackDesign.alignment = .center
            deisgn.constrainHeight(constant: 200)
            deisgn.constrainWidth(constant: 200)
            view.addSubview(vStackDesign)
            vStackDesign.centerInSuperview()
            vStack.isHidden = true
        } else {
            view.backgroundColor = .secondarySystemBackground
            cardPersonnaleController.view.constrainHeight(constant: 160)
            view.addSubview(vStack)
            vStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10))
            vStackDesign.isHidden = true
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handelLogout))
            
        }
    }
    fileprivate func setFontAndColor() {
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
        [addButton,loginButton].forEach({$0.backgroundColor = color})
        [descptionLabel,haveAccountLabel].forEach({$0.font = UIFont(name: fontName, size: 16)})
        loginButton.titleLabel?.font = UIFont(name: fontName, size: 36)!
        cardPersonnaleController.setFonts(fontName: fontName)
        infoUserTableViewController.setFonts(fontName: fontName)
        [cardPersonnaleController.editPictureButtons,cardPersonnaleController.editProfileButtons].forEach({$0.tintColor = color})
        navigationController?.navigationBar.tintColor = color
        tabBarController?.tabBar.tintColor = color
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
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
	@objc fileprivate func handlePrestenUpdateProfile() {
		let editeProfileViwController = EditeProfileViewController()
        editeProfileViwController.profileViewController = self
//        editeProfileViwController.infomation = user
        let controller = UINavigationController(rootViewController: editeProfileViwController)
		present(controller, animated: true)
	}
    @objc fileprivate func handlePrestenEditPersonnaleInfo() {
        let editeProfileViwController = EditPersonaleInfoViewController()
        editeProfileViwController.profileViewController = self
        editeProfileViwController.personal = user
        let controller = UINavigationController(rootViewController: editeProfileViwController)
        present(controller, animated: true)
    }
    @objc fileprivate func handlePrestenEditPicture() {
        let editePictureViwController = EditProfilePictureViewController()
        editePictureViwController.profileViewController = self
        editePictureViwController.picture = user
        let controller = UINavigationController(rootViewController: editePictureViwController)
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
