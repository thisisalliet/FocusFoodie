//
//  Category.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit
import Foundation
import FBLPromises

protocol CategoryObject {
        
    var title: String { get }
    
    var image: UIImage? { get }
}

enum Category: String, CategoryObject, CaseIterable {

    case work

    case school

    case chores

    case coding

    case fitness

    case gaming

    case relaxing

    case shopping

    var title: String {

        switch self {

        case .work: return "Work"

        case .school: return "School"

        case .chores: return "Chores"

        case .coding: return "Coding"

        case .fitness: return "Fitness"

        case .gaming: return "Gaming"

        case .relaxing: return "Relaxing"

        case .shopping: return "Shopping"
        }
    }

    var image: UIImage? {

        switch self {

        case .work: return UIImage.asset(.icon_work)

        case .school: return UIImage.asset(.icon_school)

        case .chores: return UIImage.asset(.icon_chores)

        case .coding: return UIImage.asset(.icon_coding)

        case .fitness: return UIImage.asset(.icon_fitness)

        case .gaming: return UIImage.asset(.icon_gaming)

        case .relaxing: return UIImage.asset(.icon_relaxing)

        case .shopping: return UIImage.asset(.icon_shopping)
        }
    }
}
