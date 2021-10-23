//
//  UILabel+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import Foundation
import UIKit

@IBDesignable
extension UILabel {
    
    var substituteFontName: String {
        
        get { return self.font.fontName }

        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
}

