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
			setControllersWithoutNav(ProfileControllerView(), "Profile", SFSymbols.profile),
            setControllers(SettingsViewController(), "Setting", SFSymbols.setting),
			]
		
//		perform(#selector(handlePresting), with: nil, afterDelay: 0)
	}
	
////	@objc func handlePresting() {
//		let loginViewScreen = MainTabBarController()
//		loginViewScreen.modalPresentationStyle = .fullScreen
//		present(loginViewScreen, animated: true)
//	}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        UITabBar.appearance().tintColor = color
        UINavigationBar.appearance().tintColor = color
//        let index =  UserDefaults.standard.integer(forKey: Keys.intKey)
//        if  index == 0 {
//            UIApplication.shared.windows.forEach { window in
//                window.overrideUserInterfaceStyle = .light
//            }
//        } else if index == 1 {
//            UIApplication.shared.windows.forEach { window in
//                window.overrideUserInterfaceStyle = .dark
//            }
//        }
    }
	fileprivate func setControllers(_ viewController : UIViewController, _ title : String,_ icon : String) -> UIViewController {
		let controller =  UINavigationController(rootViewController: viewController)
		controller.tabBarItem.title = title
		viewController.navigationItem.title = title
		controller.navigationBar.prefersLargeTitles = true
        controller.tabBarItem.image = UIImage(systemName: icon)
		controller.view.backgroundColor = .systemBackground
        
        
//        controller.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//        controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//
//        let appearance = UITabBarAppearance()
//        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGreen ]
//           tabBar.standardAppearance = appearance
        
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
