//
//  PricingTableViewController.swift
//  iDelivery
//
//  Created by mac on 10/30/20.
//

import UIKit

class PricingTableViewController: UIViewController {
	
	//Pricing
	let price = ["Price Per Order","Return Per Order","Stockage"]
	let icons = [SFSymbols.currency,SFSymbols.currency,SFSymbols.package]
	
	let values = [50,45,5]
	private let cellID = "cellID"
	let tableview: UITableView = {
		let tv = UITableView()
		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.layer.cornerRadius = 5
		return tv
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
//		view.backgroundColor = .green
		setupTableView()
	}
}
extension PricingTableViewController: UITableViewDelegate,  UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return values.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableview.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PricingTableViewCell
		let title = price[indexPath.row]
		let value = values[indexPath.row]
		let icon = icons[indexPath.row]
		
		cell.value.text = "\(value) MAD"
		cell.icon.image = UIImage(systemName: icon)
		cell.name.text = title
		return cell
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 45
	}
	func setupTableView() {
		tableview.register(PricingTableViewCell.self, forCellReuseIdentifier: cellID)
		tableview.delegate = self
		tableview.dataSource = self
		view.addSubview(tableview)

		tableview.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 5, bottom: 0, right: 5), size: .init(width: 0, height: 130))
	}
}
