//
//  SortsView.swift
//  iDelivery
//
//  Created by mac on 10/31/20.
//

import UIKit


class SortsView: UIViewController {
	
	//MARK: Properties
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
	
	let motorcycle 	=  UIImageView.init(image: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.valise)!, string: "Only :Motorcycles", color: .label,segFont: .systemFont(ofSize: 18)))
	
	let car 		=  UIImageView.init(image: UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.valise)!, string: "Only :Cars", color: .label,segFont: .systemFont(ofSize: 18)))
	
	let lowesButton 	= UIButton(SFSymbols.unSelected,color: .label)
	let highestButton 	= UIButton(SFSymbols.selected,color: .systemBlue)
	let motorButton 	= UIButton(SFSymbols.unSelected,color: .label)
	let carButton 		= UIButton(SFSymbols.unSelected,color: .label)


	var hasSetPointOrigin = false
	var pointOrigin: CGPoint?
	
	 //MARK: LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
		view.addGestureRecognizer(panGesture)
		creatUI()
		dismissKeyBoard()
//		setActions()
	}
	fileprivate func creatUI() {
		view.addSubview(slideIdicator)
		slideIdicator.translatesAutoresizingMaskIntoConstraints = false
		slideIdicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 12).isActive = true
		slideIdicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

		let hStackLowest = HStackView(arrangedSubviews: [lowest,UIView(),lowesButton], spacing: 5)
		let hStackHighest = HStackView(arrangedSubviews: [highest,UIView(),highestButton], spacing: 5)
		let hStackMotorcyle = HStackView(arrangedSubviews: [motorcycle,UIView(),motorButton], spacing: 5)
		let hStackCar = HStackView(arrangedSubviews: [car,UIView(),carButton], spacing: 5)
		let vStack = VerticalStackView(arrangedSubviews: [hStackLowest,hStackHighest,hStackMotorcyle,hStackCar], spacing: 25)
		
		view.addSubview(vStack)
		vStack.anchor(top: slideIdicator.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 40, left: 10, bottom: 0, right: 10))
		view.backgroundColor = .systemBackground
		[carButton,highestButton,lowesButton,motorButton].forEach { (size) in
			size.constrainWidth(constant: 35)
			size.constrainHeight(constant: 35)
		}
		view.addSubview(sortButton)
		sortButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 25, bottom: 20, right: 25),size: .init(width: 0, height: 48))
		sortButton.backgroundColor = .label
		sortButton.setTitleColor(.systemBackground, for: .normal)
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
	
//	fileprivate func setActions() {
//		highestButton.addTarget(self, action: #selector(handleSelectore), for: .touchUpInside)
//		carButton.addTarget(self, action: #selector(handleSelectore), for: .touchUpInside)
//		lowesButton.addTarget(self, action: #selector(handleSelectore), for: .touchUpInside)
//		motorButton.addTarget(self, action: #selector(handleSelectore), for: .touchUpInside)
//	}
	
	
//	@objc func handleSelectore() {
//		if lowesButton.isSelected  {
//			highestButton.tintColor = .label
//			lowesButton.tintColor = .systemBlue
//			carButton.tintColor = .label
//			motorButton.tintColor = .label
//		} else if motorButton.isSelected {
//			highestButton.tintColor = .label
//			lowesButton.tintColor = .label
//			carButton.tintColor = .label
//			motorButton.tintColor = .systemBlue
//		} else if carButton.isSelected {
//			highestButton.tintColor = .label
//			lowesButton.tintColor = .label
//			carButton.tintColor = .systemBlue
//			motorButton.tintColor = .label
//		} else if highestButton.isSelected {
//			highestButton.tintColor = .systemBlue
//			lowesButton.tintColor = .label
//			carButton.tintColor = .label
//			motorButton.tintColor = .label
//			motorButton.tintColor = .label
//		}
//	}
}
