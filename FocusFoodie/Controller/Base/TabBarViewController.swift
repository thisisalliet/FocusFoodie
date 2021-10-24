//
//  TabBarViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/19.
//

import UIKit

private enum Tab {

    case record

    case timer
    
    case community

    func controller() -> UIViewController {

        var controller: UIViewController

        switch self {

        case .record: controller = UIStoryboard.record.instantiateInitialViewController()!

        case .timer: controller = UIStoryboard.timer.instantiateInitialViewController()!
            
        case .community: controller = UIStoryboard.community.instantiateInitialViewController()!
        }

        controller.tabBarItem = tabBarItem()
        
        controller.tabBarItem.standardAppearance?.selectionIndicatorTintColor = .L4
        
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 40.0, left: 40.0, bottom: 40.0, right: 40.0)

        return controller
    }

    func tabBarItem() -> UITabBarItem {

        switch self {

        case .record:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.icon_category),
                selectedImage: UIImage.asset(.icon_category)
            )
            
        case .timer:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.icon_timer),
                selectedImage: UIImage.asset(.icon_timer)
            )

        case .community:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.icon_community),
                selectedImage: UIImage.asset(.icon_community)
            )
        }
    }
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    private let tabs: [Tab] = [.record, .timer, .community]

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = tabs.map({ $0.controller() })
    }
}
