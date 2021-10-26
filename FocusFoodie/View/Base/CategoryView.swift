//
//  CategoryTagView.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/21.
//

import Foundation

import UIKit

class CategoryView: UIView {
    
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var categoryLabel: UILabel! {
        
        didSet {

            categoryLabel.text = "Coding"
            
            categoryLabel.textColor = .darkGray
            
            categoryLabel.contentMode = .center
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initView()
    }

    private func initView() {

        backgroundColor = UIColor.white

        Bundle.main.loadNibNamed(
            String(describing: CategoryView.self),
            owner: self,
            options: nil
        )

        stickSubView(contentView)
    }
}
