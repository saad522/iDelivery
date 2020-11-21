//
//  SettingsViewController.swift
//  iDelivery
//
//  Created by mac on 11/18/20.
//

import SwiftUI
class SettingsViewController: UICollectionViewController {

    
    private let headerId    = "headerId"
    private let colorCellID = "colorCellID"
    private let fontsCellID = "fontsCellID"
    private let modeCellID = "modeCellID"
    private let languageCellID = "languageCellID"

    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                return SettingsViewController.pickerViewSection()
            } else  {
                // second section
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                //                section.contentInsets.leading = 16
                
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: kind, alignment: .topLeading)
                ]
                
                return section
            }
        }
        
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    var fontName : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        creatUI()
        setupCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let index =  UserDefaults.standard.integer(forKey: Keys.intKey)
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
        navigationController?.navigationBar.tintColor = color
        navigationController?.navigationBar.titleTextAttributes = [.font : UIFont(name: fontName, size: 25)! ,.foregroundColor: color]
        navigationController?.navigationBar.largeTitleTextAttributes = [.font : UIFont(name: fontName, size: 35)!]
        tabBarController?.tabBar.tintColor = color
        if  index == 0 {
            print(index)
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
        else if index == 1 {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
            print(index)
        }
        
       
    }
}
//MARK: set Delegate
//MARK: CreatUI
extension SettingsViewController {
    
    static func pickerViewSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        //    item.contentInsets.bottom = 16
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), subitems: [item])
        group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        let kind = UICollectionView.elementKindSectionHeader
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: kind, alignment: .topLeading)
        ]
        return section
    }
    fileprivate func setupNavigation() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CompositionalHeader
        var title: String?
        if indexPath.section == 0 {
            title = "Colors"
        } else if indexPath.section == 1 {
            title = "Fonts"
        } else if indexPath.section == 2 {
            title = "Dark Appearnce"
        } else {
            title = "Language"
        }
        let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
        header.label.text = title
        header.label.font = UIFont(name: fontName, size: 20)
        return header
    }
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colorCellID, for: indexPath) as! ColorPickView
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fontsCellID, for: indexPath) as! FontsPickerView
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: modeCellID, for: indexPath) as! BackGroundMode
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: languageCellID, for: indexPath) as! LanguagePickerView
            return cell
        }
    }
    
    func setupCollectionView() {
        collectionView.register(ColorPickView.self, forCellWithReuseIdentifier: colorCellID)
        collectionView.register(FontsPickerView.self, forCellWithReuseIdentifier: fontsCellID)
        collectionView.register(BackGroundMode.self, forCellWithReuseIdentifier: modeCellID)
        collectionView.register(LanguagePickerView.self, forCellWithReuseIdentifier: languageCellID)
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    fileprivate func creatUI() {
        collectionView.backgroundColor = .systemBackground
    }
}
class CompositionalHeader: UICollectionReusableView {
    
    let label = UILabel.init(text: "Color", font: .systemFont(ofSize: 20, weight: .semibold))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.fillSuperview(padding: .init(top: 10, left: 10, bottom: 0, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
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
