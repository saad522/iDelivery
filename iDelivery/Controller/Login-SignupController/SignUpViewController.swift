//
//  SignUpViewController.swift
//  iDelivery
//
//  Created by mac on 10/27/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController{
	//MARK: Properties
    var prfileViewController : ProfileControllerView?

	//Title
	let logo = UILabel(text: "iDelevry", font: UIFont(name: "Avenir-Light", size: 25)!, textColor: .label)
	//TextFields
	let fullNameText = UITextField(placholder: "Full-Name")
	let phoneText    = UITextField(placholder: "Phone (Required)")
	let emailText    = UITextField(placholder: "Email")
	let passwordText = UITextField(placholder: "Password",isPassword: true)
	let locationText = UITextField(placholder: "City")
	
	//Icons
	let fullNameIcon   = UIImageView(SFSymbols.fullName)
	let phoneIcon      = UIImageView(SFSymbols.phone)
	let passwordIcon   = UIImageView(SFSymbols.password)
	let locationIcone  = UIImageView(SFSymbols.location)
	let emailIcone     = UIImageView(SFSymbols.email)
	
	//Image
	lazy var profilePicture : UIImageView = {
		let picture = UIImageView()
		let size : CGFloat = 85
		picture.constrainWidth(constant: size)
		picture.constrainHeight(constant: size)

		picture.isUserInteractionEnabled = true
		picture.image = UIImage(systemName: SFSymbols.camera)?.withTintColor(.systemGray).withRenderingMode(.alwaysOriginal)
		picture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickerImage)))
		return picture
	}()
	
	//Buttons
	let loginUpButton  = UIButton("Aleardy have an account?","Login")
	let signUpButton   = UIButton(title: "SignUp")
//	let cameraIcon     = UIButton(SFSymbols.camera)
	let hiddenPassword = UIButton(SFSymbols.closeEye,size: 15,color: .label)
	
	//Separators
	let lineName     = UIView(.systemGray)
	let linePhon     = UIView(.systemGray)
	let linePassword = UIView(.systemGray)
	let lineLocation = UIView(.systemGray)
	let lineEmail    = UIView(.systemGray)
	
	//UIPickeView
	var pickerView = UIPickerView()
	let cities = MountainsController().generateMountains()
	var titles : [String] = []
	
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpNavigation()
		createUI()
		dismissKeyBoard()
		setActions()
		setupPickeView()
	}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        signUpButton.backgroundColor = color
        
    }
}

//MARK: SetUp UIPickeView
extension SignUpViewController : UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return cities.count
	}
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		cities.forEach({titles.append($0.name)})
		locationText.text = titles[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		cities.forEach({titles.append($0.name)})
		return titles[row]
	}
	fileprivate func setupPickeView() {
		pickerView.delegate    = self
		pickerView.dataSource  = self
		locationText.inputView = pickerView
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
		logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		
		//PictureView
		view.addSubview(profilePicture)
		profilePicture.translatesAutoresizingMaskIntoConstraints = false
		profilePicture.topAnchor.constraint(equalTo: logo.bottomAnchor).isActive = true
		profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//		//Camera Icon
//		profilePicture.addSubview(cameraIcon)
//		cameraIcon.tintColor = .systemGray
//		profilePicture.isUserInteractionEnabled = true
//		cameraIcon.centerInSuperview()

		// StackViews
		// FullName StackView
		let fullNameHS = HStackView(arrangedSubviews: [fullNameIcon,fullNameText,UIView()])
		let fullNameVS = VerticalStackView(arrangedSubviews: [fullNameHS,lineName], spacing: 8)

		// Phone StackView
		let phoneHS = HStackView(arrangedSubviews: [phoneIcon,phoneText,UIView()])
		let phoneVS = VerticalStackView(arrangedSubviews: [phoneHS,linePhon], spacing: 8)
		phoneText.keyboardType = .phonePad

		//Email StackView
		let emailHS = HStackView(arrangedSubviews: [emailIcone,emailText,UIView()])
		let emailVS = VerticalStackView(arrangedSubviews: [emailHS,lineEmail], spacing: 8)

		// Password StackView
		let passwordHS = HStackView(arrangedSubviews: [passwordIcon,passwordText,hiddenPassword])
		[passwordIcon,hiddenPassword].forEach({$0.constrainWidth(constant: 25)})
		let passwordVS = VerticalStackView(arrangedSubviews: [passwordHS,linePassword], spacing: 8)

		// Location StackView
		let locationHS = HStackView(arrangedSubviews: [locationIcone,locationText,UIView()])
		let locationVS = VerticalStackView(arrangedSubviews: [locationHS,lineLocation], spacing: 8)

		// Main Stack
		let mainStack = VerticalStackView(arrangedSubviews: [fullNameVS,phoneVS,emailVS,passwordVS,locationVS], spacing: 35)

		view.addSubview(mainStack)
		mainStack.anchor(top: profilePicture.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 15, left: 25, bottom: 0, right: 25))

		//SignUp Button
		view.addSubview(signUpButton)
		signUpButton.anchor(top: mainStack.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 30, left: 25, bottom: 0, right: 25),size: .init(width: 0, height: 50))
		//Login Button
		view.addSubview(loginUpButton)
		loginUpButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 25, bottom: 0, right: 25))
	}
	fileprivate func dismissKeyBoard() {
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
}

//MARK: UIIMAGEPICKERVIEW
extension SignUpViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
	@objc func handlePickerImage() {
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.allowsEditing = true
		present(picker, animated: true)
	}
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let imgaeEdit = info[.editedImage] as? UIImage else  { return }
		profilePicture.image = imgaeEdit
		dismiss(animated: true)

		
	}
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		print("HERE")
		dismiss(animated: true)
	}
}


extension SignUpViewController {
	fileprivate func setActions() {
		loginUpButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
		hiddenPassword.addTarget(self, action: #selector(handlePassword), for: .touchUpInside)
		signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
//		profilePicture.
	}
	
	@objc func handleSignUp() {
		guard let fullName = fullNameText.text else { return  }
        guard let phone    = phoneText.text else { return  }
        guard let location = locationText.text else { return  }
		guard let email    = emailText.text else { return  }
		guard let password = passwordText.text else { return  }
		
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed To Create User 👎🏿 reason : ",error.localizedDescription)
            }
            guard let userId = result?.user.uid else { return }
            let storage = Storage.storage().reference().child("\(userId).png")
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            if let uploadData = self.profilePicture.image!.pngData() {
                storage.putData(uploadData, metadata: metaData) { (metadata, error) in
                    if let error = error {
                        print("Failed To Upload Image  👎🏾reason : ",error.localizedDescription)
                    }
                    storage.downloadURL { (url, error) in
                        if let error = error {
                            print("Failed To download URL of Image 👎🏽 reason : ",error.localizedDescription)
                        }
                        guard let imageURL = url?.absoluteString else {return}
                        let values : [String:Any] = ["city":location,
                                                     "email":email,
                                                     "fullName":fullName,
                                                     "password":password,
                                                     "phone" : phone,
                                                     "profileImage":imageURL,
                                                     "userId":userId]
                        self.uploadUserData(values: values, docmentID: userId)
                    }
                 
                }
            }
            
            
            
        }
        
	}
    private func uploadUserData(values : [String:Any],docmentID : String) {
        let database = Firestore.firestore()
        database.collection(DB_Keys.collectionKey).document(docmentID).setData(values) { (error) in
            if let error = error {
                print("Failed To set Data 👎🏻 reason : ",error.localizedDescription)
            }
            print("We did it 👍🏿")
            self.prfileViewController?.fetchUserData()
            self.prfileViewController?.checkIfUserLoggedIn()
            self.dismiss(animated: true)
        }
//            .addDocument(data: values) { (error) in
//
//        }
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
extension UIImage {
		// image with rounded corners
		public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
			let maxRadius = min(size.width, size.height) / 2
			let cornerRadius: CGFloat
			if let radius = radius, radius > 0 && radius <= maxRadius {
				cornerRadius = radius
			} else {
				cornerRadius = maxRadius
			}
			UIGraphicsBeginImageContextWithOptions(size, false, scale)
			let rect = CGRect(origin: .zero, size: size)
			UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
			draw(in: rect)
			let image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			return image
		}
	}


enum DB_Keys {
    static let collectionKey = "users"
}
