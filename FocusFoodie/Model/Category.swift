//
//  Category.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit
import Foundation

protocol CategoryItem {
    
    var title: String  { get }
    
    var image: UIImage? { get }
}

enum Category: CategoryItem, CaseIterable {
    
    case work
    
    case sleep
    
    case chores
    
    case school
    
    case gaming
    
    case family
    
    case fitness
    
    case relaxing
    
    var title: String {
        
        switch self {
            
        case .work: return "Work"
            
        case .sleep: return "Sleep"
            
        case .chores: return "Chores"
            
        case .school: return "School"
            
        case .gaming: return "Gaming"
            
        case .family: return "Family"
            
        case .fitness: return "Fitness"
            
        case .relaxing: return "Relaxing"
        }
    }
    
    var image: UIImage? {
        
        switch self {
            
        case .work: return UIImage.asset(.icon_sleep)
            
        case .sleep: return UIImage.asset(.icon_sleep)
            
        case .chores: return UIImage.asset(.icon_sleep)
            
        case .school: return UIImage.asset(.icon_sleep)
            
        case .gaming: return UIImage.asset(.icon_sleep)
            
        case .family: return UIImage.asset(.icon_sleep)
            
        case .fitness: return UIImage.asset(.icon_fitness)
            
        case .relaxing: return UIImage.asset(.icon_sleep)
        }
    }
}
