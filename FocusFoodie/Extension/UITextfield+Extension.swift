//
//  UITextfield+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/25.
//

import Foundation
import UIKit

extension UITextField {
    
    @objc var substituteFontName: String {
        
        get { return self.font!.fontName }
        
        set { self.font = UIFont(
            name: newValue,
            size: (self.font?.pointSize)!) }
    }
}
