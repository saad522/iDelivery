//
//  MoreDetailsController.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import SwiftUI

class MoreDetailsController: UIViewController {
	
	//MARK: Properties
    fileprivate let user: User?
    
    // dependency injection constructor
    init(user: User?) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let pricingInfo = UILabel.init(text: " Pricing Information", font: UIFont(name: "GillSans-Bold", size: 21)!,textColor: .label)
    
    let toolsTableViewInformation = ToolsTableViewController()
    let personalInformation = PersonalnformationViewController()
    
    
	let dismiss = UIButton(SFSymbols.dismiss,size: 20)
	
		
	
	//MARK: LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchUserDetailData()
		creatUI()
	}
}
//MARK: setup Networking
extension MoreDetailsController {
    fileprivate func fetchUserDetailData() {
        personalInformation.user = user
        toolsTableViewInformation.user = user
    }
}
//MARK: Create UI
extension MoreDetailsController {
	fileprivate func creatUI() {
        let personalInfo = UILabel.init(text: "Personal Information", font: UIFont(name: "GillSans-Bold", size: 21)!,textColor: .label)
        view.backgroundColor = .secondarySystemBackground
        
		view.addSubview(dismiss)
		dismiss.tintColor = .label
        dismiss.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 15))
		dismiss.addTarget(self, action: #selector(handelDismiss), for: .touchUpInside)

        
        let stack = VerticalStackView(arrangedSubviews: [personalInfo,personalInformation.view,UIView(),UIView(),pricingInfo,toolsTableViewInformation.view], spacing: 10)
        personalInformation.view.constrainHeight(constant: 120)
        view.addSubview(stack)
        stack.anchor(top: dismiss.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
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
