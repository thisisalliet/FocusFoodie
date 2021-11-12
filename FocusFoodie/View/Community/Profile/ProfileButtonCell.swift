//
//  ProfileButtonCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/11.
//

import UIKit

class ProfileButtonCell: ProfileBasicCell {
    
    let button: UIButton = {
        
        let button = UIButton()
        
        button.backgroundColor = .clear
        
        button.setTitleColor(.G3, for: .normal)
        
        button.tintColor = .G3
        
        button.cornerRadius = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupLayout()
    }
    
    func setupLayout() {
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)
        ])
    }
    
//    override func layoutCell(category: String, status: String, image: UIImage) {
//        <#code#>
//    }
}

