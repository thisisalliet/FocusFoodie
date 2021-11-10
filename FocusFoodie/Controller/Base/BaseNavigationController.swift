//
//  BaseNavigationController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = true

        navigationBar.setBackgroundImage(UIImage(), for: .default)

        navigationBar.shadowImage = UIImage()
        
        navigationBar.barTintColor = UIColor.white.withAlphaComponent(0.9)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.leftBarButtonItem?.image = UIImage.asset(.icon_arrow_left)
        
        navigationItem.leftBarButtonItem?.customView?.cornerRadius = 10
        
        navigationItem.leftBarButtonItem?.customView?.alpha = 1

        navigationItem.leftBarButtonItem?.image?.withTintColor(.white)
    }
}
