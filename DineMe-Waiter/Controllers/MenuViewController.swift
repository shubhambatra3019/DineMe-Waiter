//
//  AddNewTableViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 07/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class MenuViewController: UIViewController {

    var categories = [String]()
    var items = [[MenuItem]]()
    
    let tableViewCellId = "menuCell"
    let collectionViewCellId = "myCell"
    
    let userData = User(dict: UserDefaults.standard.dictionary(forKey: "user")!)
    
    var orderID: String!
    
    let contentView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 100), collectionViewLayout: layout)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellId)
        collectionView.backgroundColor = UIColor.blue
        //collectionView.allowsMultipleSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.frame = CGRect(x: 0, y: myCollectionView.frame.height, width: UIScreen.main.bounds.width, height: 400)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MenuItemsTableViewCell.self, forCellReuseIdentifier: tableViewCellId)
        tableView.estimatedRowHeight = 100.0
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func setupViews() {
        
        contentView.addSubview(menuTableView)
        contentView.addSubview(myCollectionView)
        view.addSubview(contentView)
        
        self.contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        self.myCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.myCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.myCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.myCollectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        menuTableView.topAnchor.constraint(equalTo: self.myCollectionView.bottomAnchor).isActive = true
        menuTableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        menuTableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        menuTableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Menu"
        setupViews()
        
        getMenuForRestaurant(restaurantID: userData!.restaurants[0])
        // Do any additional setup after loading the view.
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    
    func getMenuForRestaurant(restaurantID: String) {
        let restaurantDocument = Firestore.firestore().collection("restaurants").document(restaurantID)
        restaurantDocument.getDocument { (documentSnapshot, error) in
            if error != nil {
                print("error occured")
                return
            }
            else {
                if let document = documentSnapshot {
                    let menu = document["menu"] as! [String : Any]
                    self.categories = Array(menu.keys)
                    for category in self.categories {
                        var tempArray = [MenuItem]()
                        for item in menu[category] as! [[String : Any]] {
                            tempArray.append(MenuItem(dict: item))
                        }
                        self.items.append(tempArray)
                    }
                    self.myCollectionView.reloadData()
                    self.menuTableView.reloadData()
                }
            }
        }
    }
    
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as! MenuCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.peopleLabel.text = categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ix = IndexPath(row: 0, section: indexPath.row)
        menuTableView.scrollToRow(at: ix, at: .top, animated: true)
        let cell = collectionView.cellForItem(at: indexPath)
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
        let addMenuItemVC = AddMenuItemViewController()
        addMenuItemVC.menuItem = items[indexPath.section][indexPath.row]
        addMenuItemVC.orderID = self.orderID
        self.navigationController?.present(addMenuItemVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as! MenuItemsTableViewCell
        cell.itemLabel.text = items[indexPath.section][indexPath.row].name
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
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let visibleCells = self.menuTableView.indexPathsForVisibleRows {
            if let currentSection = visibleCells.first?.section {
                let indexPath = IndexPath(row: currentSection, section: 0)
                let collectionViewCell = self.myCollectionView.cellForItem(at: indexPath)
               
                collectionViewCell?.isSelected = true
                
            }
        }
        
    }*/
}
