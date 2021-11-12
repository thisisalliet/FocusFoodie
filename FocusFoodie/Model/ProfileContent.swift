//
//  ProfileContent.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/11.
//

import UIKit
import Foundation

enum ProfileCellType: String {
    
    case profileInfo = ""
    
    case appSecurity = "BIOMETIRC PASSCODE"
    
    case appAlert = "COUNTDOWN ALERT"
    
    case appAppearance = "DARK MODE"
    
    case profileSignOut = "SIGN OUT"
    
    case profileDeletion = "DELETE ACCOUNT"
    
    case appVersion = "1.0.0"
    
    func identifier() -> String {

        switch self {

        case .profileInfo:
            
            return String(describing: ProfileInfoCell.self)

        case .appSecurity, .appAlert, .appAppearance:
            
            return String(describing: ProfileSelectionCell.self)

        case .profileSignOut, .profileDeletion:
            
            return String(describing: ProfileButtonCell.self)

        case .appVersion:
            
            return String(describing: ProfileLabelCell.self)
        }
    }
    
//    func cellForIndexPath(_ indexPath: IndexPath, tableView: UITableView, data: Profile) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier(), for: indexPath)
//
//        guard let basicCell = cell as? ProfileBasicCell else { return cell }
//
//        switch self {
//
//        case .description:
//
//            basicCell.layoutCell(product: data)

//        case .color:
//
//            basicCell.layoutCellWithColors(category: rawValue, colors: data.colors.map({ $0.code }))
//
//        case .size:
//
//            basicCell.layoutCell(category: rawValue, content: data.size)
//
//        case .stock:
//
//            basicCell.layoutCell(category: rawValue, content: String(data.stock))
//
//        case .texture:
//
//            basicCell.layoutCell(category: rawValue, content: data.texture)
//
//        case .washing:
//
//            basicCell.layoutCell(category: rawValue, content: data.wash)
//
//        case .placeOfProduction:
//
//            basicCell.layoutCell(category: rawValue, content: data.place)
//
//        case .remarks:
//
//            basicCell.layoutCell(category: rawValue, content: data.note)
//        }
//
//        return basicCell
//    }
//}
}
