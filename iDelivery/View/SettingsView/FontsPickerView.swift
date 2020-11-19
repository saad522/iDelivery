//
//  FontsPickerView.swift
//  iDelivery
//
//  Created by mac on 11/19/20.
//

import UIKit

class FontsPickerView: UIView {
    
    //MARK: Properties
    private let cellID =  "FontCollectionViewCell"
    //Fonts
    let fonts:[UIFont] = [
        UIFont(name: CustomFont.appleSDG,  size: 14)!,
        UIFont(name: CustomFont.avenir, size: 19)!,
        UIFont(name: CustomFont.gillSans, size: 30)!,
        UIFont(name: CustomFont.markerFelt, size: 18)!,
        UIFont(name: CustomFont.optima, size: 18)!,
        UIFont(name: CustomFont.palatino, size: 20)!,
        UIFont(name: CustomFont.thonburi, size: 20)!
    ]
    
    let fontName = [ CustomFont.appleSDG, CustomFont.avenir, CustomFont.gillSans, CustomFont.markerFelt, CustomFont.optima, CustomFont.palatino, CustomFont.thonburi ]
    
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
        addSubview(collectionView)
        collectionView.pin(to: self)
        layer.cornerRadius = 5
        backgroundColor = .secondarySystemBackground

//        backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FontsPickerView : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fonts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FontCollectionViewCell
        cell.fontText.font = fonts[indexPath.row]
//        cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
}
