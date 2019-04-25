//
//  RestaurantViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 08/04/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class RestaurantsViewController: UIViewController {
    
    let restaurantCellId = "restaurantCellId"
    
    let inviteCellId = "invitesCellId"
    
    var restaurants = [Restaurant]()
    
    var invites = [Invite]()
    
    let userData = User(dict: UserDefaults.standard.dictionary(forKey: "user")!)
    
    lazy var restaurantTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: restaurantCellId)
        tableView.register(InvitesTableViewCell.self, forCellReuseIdentifier: inviteCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My Restaurants"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .done, target: self, action: #selector(reloadPage))
        getRestaurantsForUser(userId: userData!.userId)
        getInvitesForUser(userEmail: userData!.email, role: "waiter")
        
    }
    
    func setupViews() {
        view.addSubview(restaurantTableView)
        
        restaurantTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        restaurantTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        restaurantTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        restaurantTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    
    func getInvitesForUser(userEmail: String, role: String) {
        let query = Firestore.firestore().collection("invites").whereField("email", isEqualTo: userEmail).whereField("accepted", isEqualTo: -1)
        
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error while getting invites \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            self.invites = []
            
            for document in snapshot.documents {
                let invite = Invite(dict: document.data(), id: document.documentID)
                self.invites.append(invite)
            }
            
            self.restaurantTableView.reloadData()
            //print(self.invites)
            
        }
    }
    
    func updateInvitesCollection(id: String, accepted: Int) {
        let query = Firestore.firestore().collection("invites").document(id)
        
        query.updateData(["accepted": accepted]) { (error) in
            if let error = error {
                print("Error while updating: \(error.localizedDescription)")
            }
            else {
                print("Document Successfully updated")
            }
        }
    }
    
    func updateUsersCollection(id: String, restaurantID: String) {
        let query = Firestore.firestore().collection("users").document(id)
        
        query.updateData(["restaurants": FieldValue.arrayUnion([restaurantID])]) { (error) in
            if let error = error {
                print("Error while updating: \(error.localizedDescription)")
            }
            else {
                print("Document Successfully Updated")
            }
        }
    }
    
    func updateRestaurantsCollection(id: String, employee: Employee) {
        let query = Firestore.firestore().collection("restaurants").document(id)
        query.updateData(["employees.\(employee.employeeID)": employee.documentData]) { (error) in
            if let error  = error {
                print("Error while updating: \(error.localizedDescription)")
            }
            else {
                print("Document Successfully Updated")
                self.getRestaurantsForUser(userId: self.userData!.userId)
            }
        }
    }
    
    @objc func acceptInviteButtonPressed(sender: UIButton) {
        print("Accept Pressed On \(sender.tag)")
        let invite = invites[sender.tag]
        let employee = Employee(employeeID: userData!.userId, employeeName: userData!.name, role: "waiter", email: userData!.email)
        updateInvitesCollection(id: invite.id, accepted: 1)
        updateUsersCollection(id: userData!.userId, restaurantID: invite.restaurantID)
        updateRestaurantsCollection(id: invite.restaurantID, employee: employee)
        
        getInvitesForUser(userEmail: "example@example.com", role: "waiter")
    }
    
    @objc func reloadPage() {
        getRestaurantsForUser(userId: userData!.userId)
        getInvitesForUser(userEmail: userData!.email, role: "waiter")
    }
    
    @objc func rejectInviteButtonPressed(sender: UIButton) {
        print("Reject Pressed On \(sender.tag)")
        let invite = invites[sender.tag]
        updateInvitesCollection(id: invite.id, accepted: 0)
        getInvitesForUser(userEmail: "example@example.com", role: "waiter")
    }
    
    func getRestaurantsForUser(userId: String) {
        let query = Firestore.firestore().collection("users").document(userData!.userId)
        self.restaurants = []
        query.getDocument { (snapshot, error) in
            if let error = error {
                print("Error Occurred \(error.localizedDescription)")
            }
            else {
                if let document = snapshot {
                    
                    let userRestaurants = document["restaurants"] as! [String]
                    for restuarantID in userRestaurants {
                        let query = Firestore.firestore().collection("restaurants").document(restuarantID)
                        
                        query.getDocument { (snapshot, error) in
                            if let error = error {
                                print("Error Occurred \(error.localizedDescription)")
                                return
                            }
                            else {
                                if let document = snapshot {
                                    let restaurant = Restaurant(dict: document.data()!, resID: document.documentID)
                                    self.restaurants.append(restaurant)
                                }
                                self.restaurantTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Active"
        }
        
        return "Invites"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return restaurants.count
        }
        
        return invites.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: restaurantCellId, for: indexPath) as! RestaurantTableViewCell
            cell.restaurantNameLabel.text = restaurants[indexPath.row].name
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: inviteCellId, for: indexPath) as! InvitesTableViewCell
            cell.restaurantLabel.text = invites[indexPath.row].restaurantName
            cell.buttonStackView.tag = indexPath.row
            cell.buttonStackView.acceptButton.addTarget(self, action: #selector(acceptInviteButtonPressed), for: .touchUpInside)
            cell.buttonStackView.rejectButton.addTarget(self, action: #selector(rejectInviteButtonPressed), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let restaurant = restaurants[indexPath.row]
            let ongoingTablesVC = OngoingTablesViewController()
            ongoingTablesVC.restaurantID = restaurant.restaurantID
            self.navigationController?.pushViewController(ongoingTablesVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80.0
        }
        else {
            return 80.0
        }
    }
}
