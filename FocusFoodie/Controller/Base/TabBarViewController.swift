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
        
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 45.0, left: 0.0, bottom: 45.0, right: 0.0)
        
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
                image: UIImage.asset(.icon_clock),
                selectedImage: UIImage.asset(.icon_clock)
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

class TabBarViewController: UITabBarController,
                            UITabBarControllerDelegate {
    
    private let tabs: [Tab] = [.record, .timer, .community]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = tabs.map({ $0.controller() })
        
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTabBarAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height *= 1.2
        
        tabBar.frame.origin.y = view.frame.height - tabBar.frame.size.height
    }
    
    func setupTabBarAppearance() {
        
        tabBar.layer.masksToBounds = true
        
        tabBar.isTranslucent = true
        
        tabBar.tintColor = .G3
        
        tabBar.barTintColor = .white
        
        tabBar.layer.cornerRadius = 25
        
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
