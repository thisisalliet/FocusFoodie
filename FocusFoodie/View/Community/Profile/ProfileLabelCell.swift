//
//  ProfileLabelCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/11.
//

import UIKit

class ProfileLabelCell: ProfileBasicCell {

    let label: UILabel = {
        
        let label = UILabel()
        
        label.backgroundColor = .clear
        
        label.textColor = .G3
        
        label.contentMode = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)
        ])
    }
    
//    override func layoutCell(category: String, status: String, image: UIImage) {
//        <#code#>
//    }
}
