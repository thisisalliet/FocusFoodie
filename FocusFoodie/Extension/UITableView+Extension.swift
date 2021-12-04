//
//  UITableView+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit

extension UITableView {
    
    func registerCellWithNib(identifier: String, bundle: Bundle?) {
        
        let nib = UINib(nibName: identifier, bundle: bundle)

        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
            // swiftlint:disable force_cast
            return dequeueReusableCell(withIdentifier: "(T.self)", for: indexPath) as! T
            // swiftlint:enable force_cast
        }
}

extension UITableViewCell {

    static var identifier: String {

        return String(describing: self)
    }
}
