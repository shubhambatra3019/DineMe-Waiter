//
//  OrderSummaryView.swift
//  DineMe-Waiter
//
//  Created by Shubham Batra on 25/02/19.
//  Copyright © 2019 Esper. All rights reserved.
//

import UIKit

class OrderSummaryView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    let summaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /*let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.font = UIFont(name: "Helvetica", size: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var totalValue: UILabel = {
       let label = UILabel()
        label.text = "$50.00"
        label.font = UIFont(name: "Helvetica", size: 26)
        label.textColor = UIColor.green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    */
    var subtotalView = CustomizedView(title: "Subtotal", value: "$40.00", frame: CGRect(x: 0, y: 0, width: 200, height: 50))

    var taxView = CustomizedView(title: "Tax", value: "$0.00", frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    
    var tipView = CustomizedView(title: "Tip", value: "$0.00", frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    
    var totalView: CustomizedView = {
       let view = CustomizedView(title: "Total", value: "$50.00", frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        view.valueLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        return view
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /*subtotalView.valueLabel.text = subTotal
        taxView.valueLabel.text = tax
        tipView.valueLabel.text = tip
        totalValue.text = total*/
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        summaryStackView.addArrangedSubview(subtotalView)
        summaryStackView.addArrangedSubview(taxView)
        summaryStackView.addArrangedSubview(tipView)
        summaryStackView.addArrangedSubview(totalView)
        addSubview(summaryStackView)
        summaryStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        summaryStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        summaryStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        summaryStackView.heightAnchor.constraint(equalToConstant: 160)
        summaryStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        /*totalStackView.addArrangedSubview(totalLabel)
        totalStackView.addArrangedSubview(totalValue)
        addSubview(totalStackView)
        totalStackView.topAnchor.constraint(equalTo: summaryStackView.bottomAnchor, constant: 20).isActive = true
        totalStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        totalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        totalStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true*/
        
    }
    
}
