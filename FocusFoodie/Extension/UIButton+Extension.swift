//
//  UIButton+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/25.
//

import Foundation
import UIKit

extension UIButton {

    @objc var substituteFontName: String {

        get { return (self.titleLabel?.font.fontName)! }

        set {
            if self.titleLabel?.font.fontName.range(of: "-Bd") == nil {
                
                self.titleLabel?.font = UIFont(
                    name: newValue,
                    size: (self.titleLabel?.font.pointSize)!)
            }
        }
    }

    @objc var substituteFontNameBold: String {

        get { return (self.titleLabel?.font.fontName)! }

        set {
            if self.titleLabel?.font.fontName.range(of: "-Bd") == nil {

                self.titleLabel?.font = UIFont(
                    name: newValue,
                    size: (self.titleLabel?.font.pointSize)!)
            }
        }
    }
}
