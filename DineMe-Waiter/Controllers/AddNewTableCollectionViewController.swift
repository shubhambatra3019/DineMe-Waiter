//
//  AddNewTableCollectionViewController.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 05/03/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class AddNewTableCollectionViewController: UIViewController {

    let peopleCollectionViewCellId = "peopleCollectionViewCell"
    
    let tableCollectionViewCellId = "tableCollectionViewCell"
    
    var people = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var tables = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17"]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
        
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        view.addSubview(selectPartySizeHeaderView)
        view.addSubview(selectPeopleCollectionView)
        view.addSubview(selectTableHeaderView)
        view.addSubview(selectTableCollectionView)
        view.addSubview(addTableButton)
        
        selectPartySizeHeaderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        selectPartySizeHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selectPartySizeHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selectPartySizeHeaderView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        selectPeopleCollectionView.topAnchor.constraint(equalTo: selectPartySizeHeaderView.bottomAnchor, constant: 10).isActive = true
        selectPeopleCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selectPeopleCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selectPeopleCollectionView.heightAnchor.constraint(equalToConstant: 110.0).isActive = true
        
        selectTableHeaderView.topAnchor.constraint(equalTo: selectPeopleCollectionView.bottomAnchor, constant: 10).isActive = true
        selectTableHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selectTableHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selectTableHeaderView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        selectTableCollectionView.topAnchor.constraint(equalTo: selectTableHeaderView.bottomAnchor, constant: 10).isActive = true
        selectTableCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selectTableCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selectTableCollectionView.bottomAnchor.constraint(equalTo: addTableButton.topAnchor).isActive = true
        
        addTableButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        addTableButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        addTableButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        addTableButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
    }
    
    @objc func addTableButtonPressed() {
        print("add table button pressed")
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
            return tables.count
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
            cell.numberLabel.text = tables[indexPath.row]
            return cell
        }
    }
    
    
    
}
