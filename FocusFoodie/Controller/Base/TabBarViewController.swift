//
//  TabBarViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/19.
//

import UIKit

private enum Tab {

    case main

    case picker
    
    case record
    
    case community

    func controller() -> UIViewController {

        var controller: UIViewController

        switch self {

        case .timer: controller = UIStoryboard.timer.instantiateInitialViewController()!

        case .record: controller = UIStoryboard.record.instantiateInitialViewController()!

        case .friend: controller = UIStoryboard.friend.instantiateInitialViewController()!
            
        case .cooking: controller = UIStoryboard.cooking.instantiateInitialViewController()!
        }

        controller.tabBarItem = tabBarItem()

        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)

        return controller
    }

    func tabBarItem() -> UITabBarItem {

        switch self {

        case .picker:
            return UITabBarItem(
                title: nil,
                image: UIImage.init(systemName: "1.circle"),
                selectedImage: UIImage.init(systemName: "1.circle")
            )

        case .record:
            return UITabBarItem(
                title: nil,
                image: UIImage.init(systemName: "2.circle"),
                selectedImage: UIImage.init(systemName: "2.circle")
            )

        case .community:
            return UITabBarItem(
                title: nil,
                image: UIImage.init(systemName: "3.circle"),
                selectedImage: UIImage.init(systemName: "3.circle")
            )
        }
    }
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    private let tabs: [Tab] = [.picker, .record, .community]

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = tabs.map({ $0.controller() })
    }
}
