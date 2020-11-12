//
//  MainTabBarController.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import UIKit


class MainTabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		viewControllers = [
			setControllers(SearchViewController(), "Search", SFSymbols.search),
			setControllersWithoutNav(ProfileControllerView(), "Profile", SFSymbols.profile)
			]
		
//		perform(#selector(handlePresting), with: nil, afterDelay: 0)
	}
	
////	@objc func handlePresting() {
//		let loginViewScreen = MainTabBarController()
//		loginViewScreen.modalPresentationStyle = .fullScreen
//		present(loginViewScreen, animated: true)
//	}
	
	fileprivate func setControllers(_ viewController : UIViewController, _ title : String,_ icon : String) -> UIViewController {
		let controller =  UINavigationController(rootViewController: viewController)
		controller.tabBarItem.title = title
		viewController.navigationItem.title = title
		controller.navigationBar.prefersLargeTitles = true
		controller.tabBarItem.image = UIImage(systemName: icon)
		controller.view.backgroundColor = .systemBackground
		return controller
		
	}
	fileprivate func setControllersWithoutNav(_ viewController : UIViewController, _ title : String,_ icon : String) -> UIViewController {
		let controller =  viewController
		controller.tabBarItem.title = title
		viewController.navigationItem.title = title
		controller.tabBarItem.image = UIImage(systemName: icon)
		return controller
		
	}
}
