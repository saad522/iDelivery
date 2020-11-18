//
//  FiltersView.swift
//  iDelivery
//
//  Created by mac on 10/31/20.
//

import UIKit


class FiltersView: UIViewController {
	
    var searchConntroller : SearchByCityController?
    
    var users : [User]?
    
    init(users : [User]) {
        self.users = users
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	//MARK: Properties
	var slideIdicator : UIView = {
		let view = UIView()
		view.constrainHeight(constant: 3)
		view.constrainWidth(constant: 85)
		view.backgroundColor = .lightGray
		return view
	}()
	let filterButton = UIButton(title: "Filter")
	let price = UIImageView.init(image: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.currency)!, string: "Price", color: .label,segFont: .systemFont(ofSize: 18)))
	
	let retruns =  UIImageView.init(image: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.currency)!, string: "Retrun", color: .label,segFont: .systemFont(ofSize: 18)))
	
	let priceMad = UILabel.init(text: "MAD", font: .systemFont(ofSize: 18))
	let retrunMad = UILabel.init(text: "MAD", font: .systemFont(ofSize: 18))
	
	let textFieldPrice : UITextField = {
		let text = UITextField()
		text.borderStyle = .line
		text.placeholder = " 10"
		text.keyboardType = .numberPad
		text.constrainWidth(constant: 100)
		return text
	}()
	let textFieldRetrun : UITextField = {
		let text = UITextField()
		text.borderStyle = .line
		text.placeholder = " 5"
		text.keyboardType = .numberPad
		text.constrainWidth(constant: 100)
		return text
	}()
	let switchPrice = UISwitch()
	let switchReturn = UISwitch()
	var hasSetPointOrigin = false
	var pointOrigin: CGPoint?
	
	 //MARK: LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
		view.addGestureRecognizer(panGesture)
		creatUI()
		dismissKeyBoard()
        setAction()
	}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        filterButton.backgroundColor = color
        [switchPrice,switchReturn].forEach({$0.onTintColor = color})
    }
	fileprivate func creatUI() {
        [switchPrice,switchReturn].forEach({$0.onTintColor = .niceBlue})
        [textFieldRetrun,textFieldPrice].forEach({$0.keyboardType = .numberPad})
		view.addSubview(slideIdicator)
		slideIdicator.translatesAutoresizingMaskIntoConstraints = false
		slideIdicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 12).isActive = true
		slideIdicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//		slideIdicator.roundCorners(.allCorners, radius: 10)

		let hStackPrice = HStackView(arrangedSubviews: [price,textFieldPrice,priceMad,UIView(),switchPrice], spacing: 10)
		let hStackRetrun = HStackView(arrangedSubviews: [retruns,textFieldRetrun,retrunMad,UIView(),switchReturn], spacing: 10)
		let vStack = VerticalStackView(arrangedSubviews: [hStackPrice,hStackRetrun], spacing: 25)
		
		view.addSubview(vStack)
		vStack.anchor(top: slideIdicator.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 45, left: 10, bottom: 0, right: 10))
		view.backgroundColor = .systemBackground
		view.addSubview(filterButton)
		filterButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 25, bottom: 25, right: 25),size: .init(width: 0, height: 48))
	}
	override func viewDidLayoutSubviews() {
		if !hasSetPointOrigin {
			hasSetPointOrigin = true
			pointOrigin = self.view.frame.origin
		}
	}
	@objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
		let translation = sender.translation(in: view)
		
		// Not allowing the user to drag the view upward
		guard translation.y >= 0 else { return }
		
		// setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
		view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
		
		if sender.state == .ended {
			let dragVelocity = sender.velocity(in: view)
			if dragVelocity.y >= 1300 {
				self.dismiss(animated: true, completion: nil)
			} else {
				// Set back to original position of the view controller
				UIView.animate(withDuration: 0.3) {
					self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
				}
			}
		}
	}
	fileprivate func dismissKeyBoard() {
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
    
   fileprivate func setAction() {
    filterButton.addTarget(self, action: #selector(handleFilter), for: .touchUpInside)
    }
    @objc func handleFilter() {
        var array : [User] = []
        guard let price = textFieldPrice.text else { return }
        guard let returns = textFieldRetrun.text else { return }
        
        if switchPrice.isOn == true && switchReturn.isOn == false {
            
             array = users?.filter({ (user) -> Bool in
               return user.price == price
             }) ?? users!
            searchConntroller?.users = array
            searchConntroller?.collectionView.reloadData()
            
        } else if switchReturn.isOn == true && switchPrice.isOn == false {
          
             array = users?.filter({ (user) -> Bool in
               return user.retruns == returns
             }) ?? users!
            searchConntroller?.users = array
            searchConntroller?.collectionView.reloadData()
            
        } else if switchReturn.isOn == true && switchPrice.isOn == true {
           
             array = users?.filter({ (user) -> Bool in
                return user.retruns >= returns && user.price >= price
             }) ?? users!
            searchConntroller?.users = array
            searchConntroller?.collectionView.reloadData()
            
        } else if switchReturn.isOn == false && switchPrice.isOn == false {
            searchConntroller?.users = users!
            searchConntroller?.collectionView.reloadData()
        }
        
        
        dismiss(animated: true)
    }
    
    func convertingToInt(arrayString : [String]) -> [Int] {
        var arrayInt : [Int] = []
        for index in arrayString {
            arrayInt.append(Int(index)!)
        }
        return arrayInt
    }
}
