//
//  BaseNavigationController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit

class TranslucentNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = true

        navigationBar.setBackgroundImage(UIImage(), for: .default)

        navigationBar.shadowImage = UIImage()
    }
}
