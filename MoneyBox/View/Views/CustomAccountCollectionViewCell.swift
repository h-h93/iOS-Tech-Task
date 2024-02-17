//
//  CustomAccountCollectionViewCell.swift
//  MoneyBox
//
//  Created by hanif hussain on 17/02/2024.
//

import UIKit

class CustomAccountCollectionViewCell: UICollectionViewCell {
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
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "greaterthan.circle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
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
        self.addSubview(imageView)
        self.addSubview(accountNameLabel)
        self.addSubview(planValueLabel)
        self.addSubview(moneyBoxAmountLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            accountNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            accountNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            accountNameLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
            accountNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            planValueLabel.topAnchor.constraint(equalTo: accountNameLabel.bottomAnchor),
            planValueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            planValueLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
            planValueLabel.heightAnchor.constraint(equalToConstant: 50),
            
            moneyBoxAmountLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor),
            moneyBoxAmountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            moneyBoxAmountLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
            moneyBoxAmountLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
