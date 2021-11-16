//
//  UIButton+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/25.
//

import UIKit
import Foundation

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


public class GradientButton: UIButton {
    public override class var layerClass: AnyClass {

        CAGradientLayer.self
    }
    private var gradientLayer: CAGradientLayer {

        // swiftlint:disable force_cast
        layer as! CAGradientLayer
        // swiftlint:enable force_cast
    }

    public var startColor: UIColor = .white {

        didSet {
            
            updateColors()
        }
    }

    public var endColor: UIColor = .red {

        didSet {
            
            updateColors()
        }
    }

    public var startPoint: CGPoint {
        get { gradientLayer.startPoint }
        set { gradientLayer.startPoint = newValue }
    }

    public var endPoint: CGPoint {
        get { gradientLayer.endPoint }
        set { gradientLayer.endPoint = newValue }
    }

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        updateColors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateColors()
    }
}

private extension GradientButton {
    
    func updateColors() {
        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
