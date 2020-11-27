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
        setFunctions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFontAndColor()
    }
    
}

//MARK: Setup TabarFunctions
extension MainTabBarController {
    fileprivate func setFunctions() {
        viewControllers = [
            setControllers(SearchViewController(), "Nearby", SFSymbols.nearby),
            setControllers(MyListViewController(), "My Lists", SFSymbols.list),
            setControllersWithoutNav(ProfileControllerView(), "Profile", SFSymbols.profile),
            setControllers(SettingsViewController(), "Setting", SFSymbols.setting),
        ]
    }
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
    //Set UI Font And UIColor
    fileprivate func setFontAndColor() {
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        UITabBar.appearance().tintColor = color
        UINavigationBar.appearance().tintColor = color
    }
    
}
