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
        
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 30.0, left: 0.0, bottom: -30.0, right: 0.0)

        return controller
    }

    func tabBarItem() -> UITabBarItem {

        switch self {

        case .record:
            return UITabBarItem(
                title: nil,
                image: UIImage.init(systemName: "1.circle"),
                selectedImage: UIImage.init(systemName: "1.circle")
            )
            
        case .timer:
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

    private let tabs: [Tab] = [.record, .timer, .community]

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = tabs.map({ $0.controller() })
    }
}
