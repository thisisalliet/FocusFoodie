//
//  UIView+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit


extension UIView {

    // Border Color
    var borderColor: UIColor? {

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
    var borderWidth: CGFloat {

        get {

            return layer.borderWidth
        }
        set {

            layer.borderWidth = newValue
        }
    }

    // Corner radius
    var cornerRadius: CGFloat {
        
        get {

            return layer.cornerRadius
        }
        set {

            layer.cornerRadius = newValue
        }
    }
    
    // MARK: - Layout -
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
    
    func addSubview(_ subview: UIView, constrainedTo anchorsView: UIView) {
        
      addSubview(subview)
        
      subview.translatesAutoresizingMaskIntoConstraints = false
        
      NSLayoutConstraint.activate([
        subview.centerXAnchor.constraint(equalTo: anchorsView.centerXAnchor),
        subview.centerYAnchor.constraint(equalTo: anchorsView.centerYAnchor),
        subview.widthAnchor.constraint(equalTo: anchorsView.widthAnchor),
        subview.heightAnchor.constraint(equalTo: anchorsView.heightAnchor)
      ])
    }
    
    // MARK: - Appearance -
    func setShadow() {
        
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor.black.cgColor
        
        self.layer.shadowOffset = CGSize.zero
        
        self.layer.shadowOpacity = 0.3
        
        self.layer.shadowRadius = 10
    }
}
