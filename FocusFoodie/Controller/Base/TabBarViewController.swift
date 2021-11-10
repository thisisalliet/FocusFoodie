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
    
    case profile

    func controller() -> UIViewController {

        var controller: UIViewController

        switch self {

        case .record: controller = UIStoryboard.record.instantiateInitialViewController()!

        case .timer: controller = UIStoryboard.timer.instantiateInitialViewController()!
            
        case .community: controller = UIStoryboard.community.instantiateInitialViewController()!
            
        case .profile: controller = UIStoryboard.profile.instantiateInitialViewController()!
        }
                
        controller.tabBarItem = tabBarItem()
        
        controller.tabBarController?.tabBar.tintColor = .white
                        
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 45.0, left: 0.0, bottom: 45.0, right: 0.0)
        
        controller.tabBarController?.tabBar.cornerRadius = 10
        
        controller.tabBarController?.tabBar.frame.size.height = 80
        
        controller.tabBarController?.tabBar.isTranslucent = false
        
        controller.tabBarController?.tabBar.barTintColor = .white

        return controller
    }

    func tabBarItem() -> UITabBarItem {

        switch self {

        case .record:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.icon_record),
                selectedImage: UIImage.asset(.icon_record)
            )
            
        case .timer:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.icon_plus),
                selectedImage: UIImage.asset(.icon_plus)
            )

        case .community:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.icon_community),
                selectedImage: UIImage.asset(.icon_community)
            )
            
        case .profile:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.icon_community),
                selectedImage: UIImage.asset(.icon_community)
            )
        }
    }
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    private let tabs: [Tab] = [.record, .timer, .community, .profile]

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = tabs.map({ $0.controller() })
        
        tabBar.tintColor = .white
    }
}
