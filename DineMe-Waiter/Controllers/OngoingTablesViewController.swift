//
//  OngoingTablesViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 01/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class OngoingTablesViewController: UIViewController {
    
    let cellId = "cellID"
    
    var ongoingTables: [Order] = []
    
    let userData = User(dict: UserDefaults.standard.dictionary(forKey: "user")!)
    
    var ongoingTablesListener: ListenerRegistration?
    
    let noTableImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "table_empty"))
        imageView.isHidden = true
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var ongoingTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(OngoingTableViewCell.self, forCellReuseIdentifier: cellId)
       tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
        
    }()
    
    var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupView() {
        view.addSubview(ongoingTableView)
        view.addSubview(logoutButton)
        view.addSubview(noTableImageView)
        
        noTableImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        noTableImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        noTableImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        noTableImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        ongoingTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        ongoingTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        ongoingTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        ongoingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.topItem?.title = "Ongoing Tables"
        //navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Ongoing Tables"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
        setupView()
        ongoingTableView.delegate = self
        ongoingTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTable))
        if userData?.restaurants.count == 0 {
            print("No Restaurants To Show")
        }
        else {
            startListeningForOngoingTables(restuarantID: (userData?.restaurants[0])!, waiterID: (userData?.userId)!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ongoingTablesListener?.remove()
        ongoingTablesListener = nil
    }
    
    @objc func addNewTable() {
        let addNewTableVC = AddNewTableCollectionViewController()
        self.navigationController?.present(addNewTableVC, animated: true, completion: nil)
    }
    
    @objc func editButtonPressed() {
        print("Edit Button Pressed")
    }
    
    @objc func logoutButtonPressed() {
        print("Logout")
        try? Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "user")
        //let loginVC = LoginViewController()
        //navigationController?.present(loginVC, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func startListeningForOngoingTables(restuarantID: String, waiterID: String) {
        let query = Firestore.firestore().collection("orders").whereField("restaurantID", isEqualTo: restuarantID).whereField("waiterID", isEqualTo: waiterID).whereField("completed", isEqualTo: false)
        ongoingTablesListener = query.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                self.noTableImageView.isHidden = false
                print("Got an error retrieving orders: \(error)")
                return
            }
            guard let snapshot = snapshot else { return }
            self.ongoingTables = []
            if snapshot.documents.count == 0 {
                self.noTableImageView.isHidden = false
                
            }
            else {
                for document in snapshot.documents {
                    print(document.data())
                    let order = Order(dict: document.data())
                    print("json converted")
                    self.ongoingTables.append(order)
                }
                self.noTableImageView.isHidden = true
                self.ongoingTableView.reloadData()
            }
        })
    }
    
}

extension OngoingTablesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ongoingTables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OngoingTableViewCell
        cell.tableLabel.text = "Table" + ongoingTables[indexPath.row].table
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = self.ongoingTables[indexPath.row]
        let orderVC = OrderPageViewController()
        orderVC.orderID = order.orderID
        self.navigationController?.pushViewController(orderVC, animated: true)
        
    }
}



