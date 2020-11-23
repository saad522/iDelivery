//
//  SettingsViewController.swift
//  iDelivery
//
//  Created by mac on 11/18/20.
//

import SwiftUI
class SettingsViewController: UICollectionViewController {

    
    private let headerId       = "headerId"
    private let colorCellID    = "colorCellID"
    private let fontsCellID    = "fontsCellID"
    private let modeCellID     = "modeCellID"
    private let languageCellID = "languageCellID"
    
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    enum Section: CaseIterable {
        case colors
        case fonts
        case mode
        case language
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupCollectionView()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFontAndColor()
        collectionView.reloadData()
    }

    
    
}
//MARK: set Delegate
//MARK: CreatUI
extension SettingsViewController {
    fileprivate func setFontAndColor() {
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
    static func pickerViewSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
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
        collectionView.backgroundColor = .systemBackground
    }
    
}
//MARK: configure CollectionView
extension SettingsViewController {
 
    func setupCollectionView() {
        collectionView.register(ColorPickView.self, forCellWithReuseIdentifier: colorCellID)
        collectionView.register(FontsPickerView.self, forCellWithReuseIdentifier: fontsCellID)
        collectionView.register(BackGroundMode.self, forCellWithReuseIdentifier: modeCellID)
        collectionView.register(LanguagePickerView.self, forCellWithReuseIdentifier: languageCellID)
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        configureDataSource()
    }
    
    func configureDataSource() {
        dataSource = .init(collectionView: self.collectionView) { (collectionView, indexPath, object) -> UICollectionViewCell? in
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.colorCellID, for: indexPath) as! ColorPickView
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.fontsCellID, for: indexPath) as! FontsPickerView
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.modeCellID, for: indexPath) as! BackGroundMode
                return cell
             case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.languageCellID, for: indexPath) as! LanguagePickerView
                return cell
            default :
                return nil
            }
        }
        setHeaders()
        var snapshot = self.dataSource.snapshot()
        snapshot.appendSections([.colors,.fonts,.mode,.language])
//        snapshot.appendItems([3])
        snapshot.appendItems([0], toSection: .colors)
        snapshot.appendItems([1], toSection: .fonts)
        snapshot.appendItems([2], toSection: .mode)
        snapshot.appendItems([3], toSection: .language)
        self.dataSource.apply(snapshot)
        
    }
    //Headers
    fileprivate func setHeaders() {
        dataSource.supplementaryViewProvider = .some({ (collectionView, kind, indexPath) -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerId, for: indexPath) as! CompositionalHeader
            
            let snapshot = self.dataSource.snapshot()
            if let object = self.dataSource.itemIdentifier(for: indexPath) {
                if let section = snapshot.sectionIdentifier(containingItem: object) {
                    if section == .colors  {
                        header.label.text = "Colors"
                    } else if section == .fonts {
                        header.label.text = "Fonts"
                    } else  if section == .mode {
                        header.label.text = "Dark Appearance"
                    } else if section == .language {
                        header.label.text = "Language"
                    }
                }
            }
            let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
            header.label.font = UIFont(name: fontName, size: 20)!
            return header
        })
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
                .previewDevice("iPhone 11 Pro")
                .edgesIgnoringSafeArea(.all)

        
    }
}
