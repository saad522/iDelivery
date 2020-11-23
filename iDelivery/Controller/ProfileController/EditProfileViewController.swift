//
//  EditProfileViewController.swift
//  iDelivery
//
//  Created by mac on 11/9/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class EditeProfileViewController: UIViewController {
    //MARK:Properties
    var profileViewController : ProfileControllerView?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFontAndColor()
    }
}

//MARK: setup Firebase
extension EditeProfileViewController {
    @objc func handleUpdate() {
        guard let price = priceText.text else { return }
        guard let retruns = retrunText.text else { return }
        guard let stockage = stockText.text else { return }
        let transport = segmentedController.selectedSegmentIndex
        let values : [String:Any] = ["price":price,
                                     "retruns":retruns,
                                     "stock":stockage,
                                     "transport":transport]
        
        guard let uiserID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection(DB_Keys.collectionKey).document(uiserID).setData(values, merge: true) { (error) in
            if let error = error {
                print("Failed to set Data 👎🏻 reason ",error.localizedDescription)
                return
            }
            print("Its's Done ✅")
            self.profileViewController?.fetchUserData()
            self.dismiss(animated: true)
        }
    }
    
    func setActions() {
        updateButton.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
}
//MARK: Create UI
extension EditeProfileViewController {
    fileprivate func setFontAndColor() {
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
        [priceText,retrunText,stockText].forEach({$0.font = UIFont(name: fontName, size: 19)})
        updateButton.titleLabel?.font = UIFont(name: fontName, size: 36)
        updateButton.backgroundColor = color
        navigationController?.navigationBar.tintColor = color
        tabBarController?.tabBar.tintColor = color
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
    }
    fileprivate func creatUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancle", style: .done, target: self, action: #selector(handleCancel))
        [priceText,retrunText,stockText].forEach({$0.keyboardType = .numberPad})
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
        
        // Set Action Of Buttons
        setActions()
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
