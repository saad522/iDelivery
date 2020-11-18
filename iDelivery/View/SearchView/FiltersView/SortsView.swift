//
//  SortsView.swift
//  iDelivery
//
//  Created by mac on 10/31/20.
//

import UIKit


class SortsView: UIViewController {
	
	//MARK: Properties
    var searchConntroller : SearchByCityController?
    
    var users : [User]?
    
    init(users : [User]) {
        self.users = users
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var slideIdicator : UIView = {
		let view = UIView()
		view.constrainHeight(constant: 3)
		view.constrainWidth(constant: 85)
		view.backgroundColor = .lightGray
		return view
	}()
    let sortButton = UIButton(title: "Sort")
	let lowest		 = UIImageView.init(image: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.currency)!, string: "Lowest first", color: .label,segFont: .systemFont(ofSize: 18)))
	
	let highest 	=  UIImageView.init(image: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.currency)!, string: "Highest first", color: .label,segFont: .systemFont(ofSize: 18)))
	
	let motorcycle 	=  UIImageView.init(image: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.valise)!, string: "Motorcycles first", color: .label,segFont: .systemFont(ofSize: 18)))
	
	let car 		=  UIImageView.init(image: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.valise)!, string: "Cars first", color: .label,segFont: .systemFont(ofSize: 18)))
	
	let lowesButton 	=  UISwitch()
	let highestButton 	=  UISwitch()
	let motorButton 	=  UISwitch()
	let carButton 		=  UISwitch()
    
	lazy var arrays = [lowesButton,highestButton,motorButton,carButton]

	var hasSetPointOrigin = false
	var pointOrigin: CGPoint?
	
	 //MARK: LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
		view.addGestureRecognizer(panGesture)
		creatUI()
		dismissKeyBoard()
		setActions()
	}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let color = UserDefaults.standard.colorForKey(key: Keys.key) ?? .niceBlue
        sortButton.backgroundColor = color
        [lowesButton,
         highestButton,
         motorButton,
         carButton,].forEach({$0.onTintColor = color})
}
	fileprivate func creatUI() {
        [lowesButton,highestButton,motorButton,carButton].forEach({$0.onTintColor = .niceBlue})
		view.addSubview(slideIdicator)
		slideIdicator.translatesAutoresizingMaskIntoConstraints = false
		slideIdicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 12).isActive = true
		slideIdicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

		let hStackLowest = HStackView(arrangedSubviews: [lowest,UIView(),lowesButton], spacing: 0)
		 lowesButton.isOn = true
		let hStackHighest = HStackView(arrangedSubviews: [highest,UIView(),highestButton], spacing: 0)
		let hStackMotorcyle = HStackView(arrangedSubviews: [motorcycle,UIView(),motorButton], spacing: 0)
		let hStackCar = HStackView(arrangedSubviews: [car,UIView(),carButton], spacing: 5)
		let vStack = VerticalStackView(arrangedSubviews: [hStackLowest,hStackHighest,hStackMotorcyle,hStackCar], spacing: 25)
		
		view.addSubview(vStack)
		vStack.anchor(top: slideIdicator.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 40, left: 10, bottom: 0, right: 10))
		view.backgroundColor = .systemBackground
		view.addSubview(sortButton)
		sortButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 25, bottom: 20, right: 25),size: .init(width: 0, height: 48))
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
	
	fileprivate func setActions() {
		lowesButton.addTarget(self, action: #selector(handleLowOn), for: .touchUpInside)
		highestButton.addTarget(self, action: #selector(handleHiOn), for: .touchUpInside)
		carButton.addTarget(self, action: #selector(handleCarOn), for: .touchUpInside)
		motorButton.addTarget(self, action: #selector(handleMoOn), for: .touchUpInside)
        sortButton.addTarget(self, action: #selector(handleSort), for: .touchUpInside)
	}
    @objc func handleSort() {
        dismiss(animated: true)
    }
	@objc func handleHiOn() {
		if highestButton.isOn == true {
			lowesButton.isOn = false
			carButton.isOn = false
			motorButton.isOn = false
            self.searchConntroller?.users = (users?.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.price > rhs.price
            }))!
            self.searchConntroller?.users.forEach({print($0.price)})
            self.searchConntroller?.collectionView.reloadData()
    
		}
	}
	@objc func handleCarOn() {
		if carButton.isOn == true {
			highestButton.isOn = false
			lowesButton.isOn = false
			motorButton.isOn = false
            self.searchConntroller?.users = (users?.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.transport == 1
            }))!
            self.searchConntroller?.users.forEach({print($0.price)})
            self.searchConntroller?.collectionView.reloadData()
            
		}
	}
	@objc func handleMoOn() {
		 if motorButton.isOn == true {
			highestButton.isOn = false
			carButton.isOn = false
			lowesButton.isOn = false
            self.searchConntroller?.users = (users?.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.transport == 0
            }))!
            self.searchConntroller?.users.forEach({print($0.price)})
            self.searchConntroller?.collectionView.reloadData()
            
		}
	}
	@objc func handleLowOn() {
		if  lowesButton.isOn == true {
			highestButton.isOn = false
			carButton.isOn = false
			motorButton.isOn = false
            self.searchConntroller?.users = (users?.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.price < rhs.price
            }))!
            self.searchConntroller?.users.forEach({print($0.price)})
            self.searchConntroller?.collectionView.reloadData()
		}
	}
	

}
