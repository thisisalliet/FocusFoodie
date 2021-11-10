//
//  UIStoryboard+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit

private enum StoryboardCategory: String {

    case main = "Main"
    
    case record = "Record"
    
    case timer = "Timer"
    
    case community = "Community"
    
    case profile = "Profile"
    
    case auth = "Auth"
}

extension UIStoryboard {

    static var main: UIStoryboard { return storyBoard(name: StoryboardCategory.main.rawValue) }

    static var record: UIStoryboard { return storyBoard(name: StoryboardCategory.record.rawValue) }

    static var timer: UIStoryboard { return storyBoard(name: StoryboardCategory.timer.rawValue) }

    static var community: UIStoryboard { return storyBoard(name: StoryboardCategory.community.rawValue) }
    
    static var profile: UIStoryboard { return storyBoard(name: StoryboardCategory.profile.rawValue) }

    static var auth: UIStoryboard { return storyBoard(name: StoryboardCategory.auth.rawValue) }

    private static func storyBoard(name: String) -> UIStoryboard {

        return UIStoryboard(name: name, bundle: nil)
    }
}
