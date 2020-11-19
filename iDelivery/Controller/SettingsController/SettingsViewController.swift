//
//  SettingsViewController.swift
//  iDelivery
//
//  Created by mac on 11/18/20.
//

import SwiftUI
class SettingsViewController: UIViewController {
    
    var colorPickerView = ColorPickView()
    var backGroundMode = BackGroundMode()
    var fontsPickeView = FontsPickerView()
    
    let colorTitle = UILabel.init(text: "Color", font: .systemFont(ofSize: 35, weight: .semibold))
    let backGroundTitle = UILabel.init(text: "Dark Appearance", font: .systemFont(ofSize: 35, weight: .semibold))
    let fontsTitle = UILabel.init(text: "Fonts", font: .systemFont(ofSize: 35, weight: .semibold))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        creatUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let index =  UserDefaults.standard.integer(forKey: Keys.intKey)
//        print(index)
//        backGroundMode.setUIMode()
//        let index =  UserDefaults.standard.integer(forKey: Keys.intKey)
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

extension SettingsViewController {
    fileprivate func setupNavigation() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
    }
    
    fileprivate func creatUI() {
        view.addSubview(colorTitle)
        colorTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        view.addSubview(colorPickerView)
        colorPickerView.anchor(top: colorTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: 100))
        view.addSubview(backGroundTitle)
        backGroundTitle.anchor(top: colorPickerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        view.addSubview(backGroundMode)
        backGroundMode.anchor(top: backGroundTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: 48))
        
        view.addSubview(fontsTitle)
        fontsTitle.anchor(top: backGroundMode.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        
        view.addSubview(fontsPickeView)
        fontsPickeView.anchor(top: fontsTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: 60))
       
    }
}
struct SettingsView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: SettingsViewController())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .edgesIgnoringSafeArea(.all)
    }
}
