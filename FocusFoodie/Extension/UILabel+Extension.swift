//
//  UILabel+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import Foundation
import UIKit

extension UILabel {
    
    @objc var substituteFontName: String {
        
        get { return self.font.fontName }
        
        set {
            if self.font.fontName.range(of:"-Bd") == nil {
                
                self.font = UIFont(
                    name: newValue,
                    size: self.font.pointSize)
            }
        }
    }
    
    @objc var substituteFontNameBold: String {
        
        get { return self.font.fontName }
        
        set {
            if self.font.fontName.range(of:"-Bd") != nil {
                self.font = UIFont(
                    name: newValue,
                    size: self.font.pointSize)
            }
        }
    }
}
