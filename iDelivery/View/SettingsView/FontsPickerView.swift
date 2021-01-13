//
//  FontsPickerView.swift
//  iDelivery
//
//  Created by mac on 11/19/20.
//

import UIKit

class FontsPickerView: UICollectionViewCell {
    
    //MARK: Properties
    private let cellID =  "FontCollectionViewCell"
    
    let fontsSiez : CGFloat = 25
    //Fonts
    lazy var fonts:[UIFont] = [
        UIFont(name: CustomFont.appleSDG,     size: fontsSiez)!,
        UIFont(name: CustomFont.avenir,       size: fontsSiez)!,
        UIFont(name: CustomFont.gillSans,     size: fontsSiez)!,
        UIFont(name: CustomFont.markerFelt,   size: fontsSiez)!,
        UIFont(name: CustomFont.optima,       size: fontsSiez)!,
        UIFont(name: CustomFont.palatino,     size: fontsSiez)!,
        UIFont(name: CustomFont.thonburi,     size: fontsSiez)!,
        
        UIFont(name: CustomFont.cochin,       size: fontsSiez)!,
        UIFont(name: CustomFont.chalkduster,  size: fontsSiez)!,
        UIFont(name: CustomFont.copperplate,  size: fontsSiez)!,
        UIFont(name: CustomFont.arialMT,      size: fontsSiez)!,
        UIFont(name: CustomFont.georgia,      size: fontsSiez)!,
        UIFont(name: CustomFont.hoeflerText,  size: fontsSiez)!,
        UIFont(name: CustomFont.chalkboardSE, size: fontsSiez)!
    ]
    
    
    lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(FontCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        cv.backgroundColor = .clear
        cv.setCollectionViewLayout(layout, animated: false)
        cv.delegate = self
        cv.dataSource = self
        cv.delaysContentTouches = false
        cv.contentInset = UIEdgeInsets(top: 0, left:10 , bottom: 0, right: 10)
        return cv
    }()
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: configure CollectionView
extension FontsPickerView : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    fileprivate func creatUI() {
        addSubview(collectionView)
        collectionView.pin(to: self)
        layer.cornerRadius = 5
        backgroundColor = .secondarySystemBackground
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fonts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FontCollectionViewCell
        cell.fontText.font = fonts[indexPath.row]
        print("This gonna Work Perfectly trus me".transformed(using: String.gobiLetters)) // 🅣🅗🅘🅢 🅦🅞🅡🅚🅢
        UIPasteboard.general.string = "This gonna Work Perfectly trus me".transformed(using: String.gobiLetters)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let font = fonts[indexPath.item].fontName
        print("Fonts Name is \(font)")
       
        UserDefaults.standard.setValue(font, forKey: Keys.fontsKeys)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
extension String {
    // A few sample ranges to get started
    // NOTE: Make sure each mapping pair has the same number of characters or bad things may happen
    static let circledLetters: [ClosedRange<UnicodeScalar> : ClosedRange<UnicodeScalar>] = ["A"..."Z" : "🅐"..."🅩", "a"..."z" : "🅐"..."🅩"]
    static let gobiLetters: [ClosedRange<UnicodeScalar> : ClosedRange<UnicodeScalar>] = ["A"..."Z" : "𝕬"..."𝖅", "a"..."z" : "𝖆"..."𝖟"]
    static let boxedLetters: [ClosedRange<UnicodeScalar> : ClosedRange<UnicodeScalar>] = ["A"..."Z" : "🅰"..."🆉", "a"..."z" : "🅰"..."🆉"]
    static let italicLetters: [ClosedRange<UnicodeScalar> : ClosedRange<UnicodeScalar>] = ["A"..."Z" : "𝐴"..."𝑍", "a"..."z" : "𝑎"..."𝑧"]

    func transformed(using mapping: [ClosedRange<UnicodeScalar> : ClosedRange<UnicodeScalar>]) -> String {
        let chars: [UnicodeScalar] = self.unicodeScalars.map { ch in
            for transform in mapping {
                // If the character is found in the range, convert it
                if let offset = transform.key.firstIndex(of: ch) {
                    // Convert the offset from key range into an Int
                    let dist = transform.key.distance(from: transform.key.startIndex, to: offset)
                    // Build new index into value range
                    let newIndex = transform.value.index(transform.value.startIndex, offsetBy: dist)
                    // Get the mapped character
                    let newch = transform.value[newIndex]
                    return newch
                }
            }

            // Not found in any of the mappings so return the original as-is
            return ch
        }

        // Convert the final [UnicodeScalar] into a new String
        var res = ""
        res.unicodeScalars.append(contentsOf: chars)

        return res
    }
}
extension UnicodeScalar: Strideable {
    public func distance(to other: UnicodeScalar) -> Int {
        return Int(other.value) - Int(self.value)
    }

    public func advanced(by n: Int) -> UnicodeScalar {
        let advancedValue = n + Int(self.value)
        guard let advancedScalar = UnicodeScalar(advancedValue) else {
            fatalError("\(String(advancedValue, radix: 16)) does not represent a valid unicode scalar value.")
        }
        return advancedScalar
    }
}
