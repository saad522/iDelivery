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
    
    let colorTitle = UILabel.init(text: "Color", font: .systemFont(ofSize: 35, weight: .semibold))
    let backGroundTitle = UILabel.init(text: "Dark Appearance", font: .systemFont(ofSize: 35, weight: .semibold))
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        creatUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backGroundMode.setUIMode()
//        let index =  UserDefaults.standard.integer(forKey: Keys.intKey)
//        if  index == 0 {
//            print(index)
//            UIApplication.shared.windows.forEach { window in
//                window.overrideUserInterfaceStyle = .light
//            }
//        } else if index == 1 {
//            UIApplication.shared.windows.forEach { window in
//                window.overrideUserInterfaceStyle = .dark
//            }
//            print(index)
//        }
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
        colorPickerView.anchor(top: colorTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: 150))
        view.addSubview(backGroundTitle)
        backGroundTitle.anchor(top: colorPickerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        view.addSubview(backGroundMode)
        backGroundMode.anchor(top: backGroundTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: 48))
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



//extension UserDefaults {
//    var theme: Theme {
//        get {
//            register(defaults: [#function: Theme.device.rawValue])
//            return Theme(rawValue: integer(forKey: #function)) ?? .device
//        }
//        set {
//            set(newValue.rawValue, forKey: #function)
//        }
//    }
//}
//
//enum Theme: Int {
//    case device
//    case light
//    case dark
//}
//
//extension Theme {
//    var userInterfaceStyle: UIUserInterfaceStyle {
//        switch self {
//        case .device:
//            return .unspecified
//        case .light:
//            return .light
//        case .dark:
//            return .dark
//        }
//    }
//}
//final class ThemeTableViewController: UITableViewController {
//    var defaults = UserDefaults.standard
//    private var theme: Theme {
//        get {
//            return defaults.theme
//        }
//        set {
//            defaults.theme = newValue
//            configureStyle(for: newValue)
//        }
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        configureCell(for: theme, checked: true)
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row != theme.rawValue {
//            configureCell(for: theme, checked: false)
//            theme = Theme(rawValue: indexPath.row) ?? .device
//            configureCell(for: theme, checked: true)
//        }
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    private func configureCell(for theme: Theme, checked: Bool) {
//        let cell = tableView.cellForRow(at: IndexPath(row: theme.rawValue, section: 0))
//        cell?.accessoryType = checked ? .checkmark : .none
//    }
//
//    private func configureStyle(for theme: Theme) {
//        view.window?.overrideUserInterfaceStyle = theme.userInterfaceStyle
//    }
//}
//
//
//final class TextViewController: UIViewController {
//    var text: String? {
//        didSet {
//            textView?.text = text
//        }
//    }
//
//    @IBOutlet private var textView: UITextView?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        text = """
//        “Here's to the crazy ones.
//        """
//    }
//}
