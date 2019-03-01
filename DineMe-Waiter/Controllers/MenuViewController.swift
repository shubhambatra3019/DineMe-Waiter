//
//  AddNewTableViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 07/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let categories = ["Chicken", "Lamb", "Specials", "Dessert", "Drinks", "Veg"]
    let items = [["Chicken1","Chicken1","Chicken1","Chicken1","Chicken1","Chicken1"], ["Lamb1","Lamb1","Lamb1","Lamb1","Lamb1","Lamb1"], ["Specials1", "Specials1", "Specials1", "Specials1", "Specials1", "Specials1"], ["Chicken1","Chicken1","Chicken1","Chicken1","Chicken1","Chicken1"], ["Chicken1","Chicken1","Chicken1","Chicken1","Chicken1","Chicken1"], ["Chicken1","Chicken1","Chicken1","Chicken1","Chicken1","Chicken1"]]
    
    let tableViewCellId = "menuCell"
    let collectionViewCellId = "myCell"
    
    lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 100), collectionViewLayout: layout)
        collectionView.register(AddNewTableCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellId)
        collectionView.backgroundColor = UIColor.blue
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.frame = CGRect(x: 0, y: myCollectionView.frame.height, width: UIScreen.main.bounds.width, height: 400)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MenuItemsTableViewCell.self, forCellReuseIdentifier: tableViewCellId)
        
        tableView.estimatedRowHeight = 100.0
        return tableView
    }()
    
    func setupTableView() {
        view.addSubview(menuTableView)
        menuTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        menuTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        menuTableView.topAnchor.constraint(equalTo: self.myCollectionView.bottomAnchor).isActive = true
        menuTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myCollectionView)
        setupCollectionView()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    func setupCollectionView() {
        self.myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        self.myCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.myCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.myCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as! AddNewTableCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.peopleLabel.text = categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ix = IndexPath(row: 0, section: indexPath.row)
        menuTableView.scrollToRow(at: ix, at: .top, animated: true)
        let cell = collectionView.cellForItem(at: indexPath)
        print(indexPath.row)
        print(indexPath.section)
        cell?.isSelected = true
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as! MenuItemsTableViewCell
        cell.itemLabel.text = items[indexPath.section][indexPath.row]
        //cell.descriptionLabel.text = menuItems[indexPath.row].itemDescription
        //cell.priceLabel.text = String(menuItems[indexPath.row].itemPrice)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

}
