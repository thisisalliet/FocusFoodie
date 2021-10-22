//
//  UIView+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit

@IBDesignable
extension UIView {

    // Border Color
    @IBInspectable var borderColor: UIColor? {

        get {

            guard let borderColor = layer.borderColor else {

                return nil
            }

            return UIColor(cgColor: borderColor)
        }
        set {

            layer.borderColor = newValue?.cgColor
        }
    }

    // Border width
    @IBInspectable var borderWidth: CGFloat {

        get {

            return layer.borderWidth
        }
        set {

            layer.borderWidth = newValue
        }
    }

    // Corner radius
    @IBInspectable var cornerRadius: CGFloat {
        
        get {

            return layer.cornerRadius
        }
        set {

            layer.cornerRadius = newValue
        }
    }
    
    func stickSubView(_ objectView: UIView) {

        objectView.removeFromSuperview()

        addSubview(objectView)

        objectView.translatesAutoresizingMaskIntoConstraints = false

        objectView.topAnchor.constraint(equalTo: topAnchor).isActive = true

        objectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true

        objectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        objectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func stickSubView(_ objectView: UIView, inset: UIEdgeInsets) {

        objectView.removeFromSuperview()

        addSubview(objectView)

        objectView.translatesAutoresizingMaskIntoConstraints = false

        objectView.topAnchor.constraint(equalTo: topAnchor, constant: inset.top).isActive = true

        objectView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.left).isActive = true

        objectView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset.right).isActive = true

        objectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset.bottom).isActive = true
    }
    
//    func loadNib() -> UIView {
//
//        let bundle = Bundle(for: type(of: self))
//
//        let nibName = type(of: self).description().components(separatedBy: ".").last!
//
//        let nib = UINib(nibName: nibName, bundle: bundle)
//
//        return nib.instantiate(withOwner: self, options: nil).first as! UIView
//    }
}
