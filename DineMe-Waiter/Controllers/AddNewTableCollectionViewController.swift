//
//  AddNewTableCollectionViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 05/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AddNewTableCollectionViewController: UIViewController {

    let peopleCollectionViewCellId = "peopleCollectionViewCell"
    
    let tableCollectionViewCellId = "tableCollectionViewCell"
    
    var people = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    let userData = User(dict: UserDefaults.standard.dictionary(forKey: "user")!)
    
    var restaurantID: String!
    
    var tables = [Table]()
    
    var availableTables = [Table]()
    
    let selectPartySizeHeaderView: HeaderView = {
        let view = HeaderView(title: "Select Party Size", frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let selectTableHeaderView: HeaderView = {
        let view = HeaderView(title: "Select Table", frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var selectPeopleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.register(AddNewTableCollectionViewCell.self, forCellWithReuseIdentifier: peopleCollectionViewCellId)
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.tag = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var selectTableCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.register(AddNewTableCollectionViewCell.self, forCellWithReuseIdentifier: tableCollectionViewCellId)
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.tag = 1
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let addTableButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Table", for: .normal)
        button.addTarget(self, action: #selector(addTableButtonPressed), for: .touchUpInside)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20.0)
        button.backgroundColor = UIColor.green
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let restaurantID = userData?.restaurants[0]
        getTablesFromFirebase(restaurantID: restaurantID!)
    }
    
    func setupViews() {
        view.addSubview(selectPartySizeHeaderView)
        view.addSubview(selectPeopleCollectionView)
        view.addSubview(selectTableHeaderView)
        view.addSubview(selectTableCollectionView)
        view.addSubview(addTableButton)
        view.addSubview(closeButton)
        
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        selectPartySizeHeaderView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 5).isActive = true
        selectPartySizeHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        selectPartySizeHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        selectPartySizeHeaderView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        
        selectPeopleCollectionView.topAnchor.constraint(equalTo: selectPartySizeHeaderView.bottomAnchor, constant: 10).isActive = true
        selectPeopleCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        selectPeopleCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        selectPeopleCollectionView.heightAnchor.constraint(equalToConstant: 110.0).isActive = true
        
        selectTableHeaderView.topAnchor.constraint(equalTo: selectPeopleCollectionView.bottomAnchor, constant: 10).isActive = true
        selectTableHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        selectTableHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        selectTableHeaderView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        
        selectTableCollectionView.topAnchor.constraint(equalTo: selectTableHeaderView.bottomAnchor, constant: 10).isActive = true
        selectTableCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        selectTableCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        selectTableCollectionView.bottomAnchor.constraint(equalTo: addTableButton.topAnchor).isActive = true
        
        addTableButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addTableButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addTableButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        addTableButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
    }
    
    func getTablesFromFirebase(restaurantID: String) {
        let query = Firestore.firestore().collection("restaurants").document(restaurantID)
        
        query.getDocument { (document, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            if let document = document {
                let dict = document["tables"] as! [String: Any]
                self.getAvailableTables(tablesDict: dict)
            }
        }
    }
    
    func getAvailableTables(tablesDict: [String: Any]){
        self.tables = []
        let arrayKeys = Array(tablesDict.keys)
        
        let sortedKeys = arrayKeys.sorted { (str1, str2) -> Bool in
            return Int(str1)! < Int(str2)!
        }
        
        for key in sortedKeys {
            let table = Table(dict: tablesDict[key] as! [String : Any])
            self.tables.append(table)
        }
        self.availableTables = []
    
        for table in tables {
            if (table.available == true) {
                self.availableTables.append(table)
            }
        }
        self.selectTableCollectionView.reloadData()
    }
    
    func isTableAvailable(tableName: Int, partySize: Int, restaurantID: String){
        let query = Firestore.firestore().collection("restaurants").document(restaurantID)
        
        query.getDocument { (document, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            if let document = document {
                let dict = document["tables"] as! [String: Any]
                let table_name = String(tableName)
                if (dict.keys.contains(table_name)) {
                    let table = Table(dict: dict[table_name] as! [String : Any])
                    if table.available == true {
                        self.updateTableFirebase(table_name: table_name, restaurantID: restaurantID)
                        self.addNewOrder(table_name: table_name, partySize: partySize)
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        
                        self.getAvailableTables(tablesDict: dict)
                        print("Table not available anymore")
                    }
                }
            }
        
        }
    }
    
    func updateTableFirebase(table_name: String, restaurantID: String) {
        let query = Firestore.firestore().collection("restaurants").document(restaurantID)
        query.updateData([
            "tables.\(table_name).available": false
        ]) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            }
            else {
                print("Document Successfuly Updated")
            }
        }
    }
    
    func addNewOrder(table_name: String, partySize: Int) {
        
        let docRef = Firestore.firestore().collection("orders").document()
        
        //let newOrder = Order(table: table_name, completed: false, restaurantID: (userData?.restaurants[0])!, waiterID: (userData?.userId)!, paidDateTime: Date(), partySize: partySize)
        
        let newOrder = Order(table: table_name, completed: false, restaurantID: restaurantID, waiterID: userData!.userId, paidDateTime: Date(), orderID: docRef.documentID, partySize: partySize)
    
        docRef.setData(newOrder.documentData) { (error) in
            if let error = error {
                print("Error while adding Document \(error.localizedDescription)")
            }
            else {
                print("Document Added")
            }
        }
        
    }
    
    @objc func addTableButtonPressed() {
        let selected = self.selectTableCollectionView.indexPathsForSelectedItems
        let selectedPeople = self.selectPeopleCollectionView.indexPathsForSelectedItems
        
        if selected?.count == 0 || selectedPeople?.count == 0{
            print("Select something ")
        }
        else {
            let selectedTable = selected?.first
            let selectedPartySize = selectedPeople?.first
            let table = self.availableTables[selectedTable!.row]
            let partySize = Int(self.people[selectedPartySize!.row]) ?? 2
            
            isTableAvailable(tableName: table.tableName, partySize: partySize, restaurantID: restaurantID)
            
        }
    }
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddNewTableCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return people.count
        }
        
        if collectionView.tag == 1 {
            return availableTables.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleCollectionViewCellId, for: indexPath) as! AddNewTableCollectionViewCell
            cell.numberLabel.text = people[indexPath.row]
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tableCollectionViewCellId, for: indexPath) as! AddNewTableCollectionViewCell
            cell.numberLabel.text = String(availableTables[indexPath.row].tableName)
            return cell
        }
    }
    
    
    
}
