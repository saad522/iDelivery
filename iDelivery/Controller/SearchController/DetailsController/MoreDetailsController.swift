//
//  MoreDetailsController.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import SwiftUI
import CoreData
class MoreDetailsController: UIViewController {
	
	//MARK: Properties
    fileprivate let user: User?
    
    let pricingInfo  = UILabel(text: " Pricing Information")
    let personalInfo = UILabel(text: "Personal Information")
    
    let toolsTableViewInformation = ToolsTableViewController()
    let personalInformation       = PersonalnformationViewController()
    
	let dismiss = UIButton(SFSymbols.dismiss,size: 18)
    let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .medium)
    lazy var  addToList : UIButton = {
        let button = UIButton(type : .system)
        button.setImage(UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.list,withConfiguration: configuration)!, string: "Add To List", color: .white, imageAlignment: 0, segFont: UIFont.systemFont(ofSize: 30, weight: .semibold)), for: .normal)
        button.layer.cornerRadius = 5
        button.shadow()
        button.backgroundColor = .niceBlue
        return button
    }()
    
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchUserDetailData()
		creatUI()
        
	}
    // dependency injection constructor
    init(user: User?) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFontAndColor()
        
    }
    deinit {
        print("No Retain cycle More detal")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: setup Networking
extension MoreDetailsController {
    fileprivate func fetchUserDetailData() {
        personalInformation.user = user
        toolsTableViewInformation.user = user
    }
    fileprivate func setActions() {
        addToList.addTarget(self, action: #selector(handleAddToList), for: .touchUpInside)
    }
    @objc fileprivate func handleAddToList() {
        let creatListViewController = CreateListViewController()
        let item = Item(context: PersistenceServce.context)
        item.city = user?.city
        item.email = user?.email
        item.image = user?.profileImage
        item.price = user?.price ?? "00"
        item.returns = user?.retruns ?? "00"
        item.stock = user?.stock ?? "00"
        item.machine = Int16(user?.transport ?? 0)
        item.name = user?.fullName
        item.phone = user?.phone
        item.id = UUID()
        creatListViewController.item = item
        present(creatListViewController, animated: true)
    }
}
//MARK: Create UI
extension MoreDetailsController {
	fileprivate func creatUI() {
        setActions()
        view.backgroundColor = .secondarySystemBackground
		view.addSubview(dismiss)
        dismiss.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 15))
		dismiss.addTarget(self, action: #selector(handelDismiss), for: .touchUpInside)

      
        let stack = VerticalStackView(arrangedSubviews: [personalInfo,personalInformation.view,UIView(),UIView(),pricingInfo,toolsTableViewInformation.view], spacing: 10)
        personalInformation.view.constrainHeight(constant: 110)
        view.addSubview(stack)
        stack.anchor(top: dismiss.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        view.addSubview(addToList)
        addToList.anchor(top: stack.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 15, left: 55, bottom: 0, right: 55),size: .init(width: 0, height: 48))
        addToList.tintColor = .white
	}
    fileprivate func setFontAndColor() {
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
        personalInfo.font = UIFont(name: fontName, size: 21)!
        pricingInfo.font = UIFont(name: fontName, size: 21)!
        dismiss.tintColor = color
    }
	@objc func handelDismiss() {
		dismiss(animated: true)
	}
}
struct MoreDetails: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
        let moreDetailsController = MoreDetailsController(user: nil)
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
