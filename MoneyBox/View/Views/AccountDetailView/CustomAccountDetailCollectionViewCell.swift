//
//  CustomAccountCollectionViewCell.swift
//  MoneyBox
//
//  Created by hanif hussain on 17/02/2024.
//

import UIKit

class CustomAccountDetailCollectionViewCell: UICollectionViewCell {
    var accountNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.textColor = .black
        return label
    }()
    
    var planValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    var moneyBoxAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    let topUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add £10", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        let colour = UIColor(red: 42/255, green: 216/255, blue: 202/255, alpha: 1)
        button.backgroundColor = colour
        button.layer.borderWidth = 0.3
        button.dropShadow(shadowRadius: 4)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.dropShadow(shadowRadius: 2)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(topUpButton)
        self.addSubview(accountNameLabel)
        self.addSubview(planValueLabel)
        self.addSubview(moneyBoxAmountLabel)
        
        NSLayoutConstraint.activate([
            
            topUpButton.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            topUpButton.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            topUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            topUpButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            accountNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            accountNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            accountNameLabel.trailingAnchor.constraint(equalTo: topUpButton.leadingAnchor, constant: -10),
            accountNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            planValueLabel.topAnchor.constraint(equalTo: accountNameLabel.bottomAnchor),
            planValueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            planValueLabel.trailingAnchor.constraint(equalTo: topUpButton.leadingAnchor, constant: -10),
            planValueLabel.heightAnchor.constraint(equalToConstant: 50),
            
            moneyBoxAmountLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor),
            moneyBoxAmountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            moneyBoxAmountLabel.trailingAnchor.constraint(equalTo: topUpButton.leadingAnchor, constant: -10),
            moneyBoxAmountLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
