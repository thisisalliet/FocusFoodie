//
//  UICollectionView+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit

extension UICollectionView {

    func registerCellWithNib(identifier: String, bundle: Bundle?) {

        let nib = UINib(nibName: identifier, bundle: bundle)

        register(nib, forCellWithReuseIdentifier: identifier)
    }
}

extension UICollectionViewCell {
    
        static var reuseIdentifier: String {

            return String(describing: self)
        }
}
