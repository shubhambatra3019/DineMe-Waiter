//
//  OrderedItemsSummaryTableViewCell.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 27/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class OrderedItemsSummaryTableViewCell: UITableViewCell {

    
    let summaryView: OrderSummaryView = {
        let view = OrderSummaryView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }*/
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupViews() {
        addSubview(summaryView)
        summaryView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        summaryView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        summaryView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        summaryView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
