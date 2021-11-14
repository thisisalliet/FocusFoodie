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
    
    case appAppearance = "DARK MODE COMING SOON"
    
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
    
    func cellForIndexPath(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier(), for: indexPath)
        
        guard let basicCell = cell as? ProfileBasicCell else { return cell }
        
        switch self {
            
        case .profileInfo:
            
            basicCell.layoutCellWithInfo(
                name: UserManager.shared.userDisplayName,
                email: UserManager.shared.userEmail)
            
        case .appSecurity:
            
            basicCell.layoutCellWithSwitch(
                status: false,
                category: rawValue,
                image: nil)
            
        case .appAlert:
            
            basicCell.layoutCellWithSwitch(
                status: true,
                category: rawValue,
                image: nil)
            
        case .appAppearance:
            
            basicCell.layoutCellWithLabel(
                content: rawValue)
            
        case .profileSignOut:
            
            basicCell.layoutCellWithButton(
                buttonTitle: rawValue)
            
        case .profileDeletion:
            
            basicCell.layoutCellWithButton(
                buttonTitle: rawValue)
            
        case .appVersion:
            
            basicCell.layoutCellWithLabel(
                content: rawValue)
        }
        
        return basicCell
    }
}
