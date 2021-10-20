//
//  UIStoryboard+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit

private enum StoryboardCategory: String {

    case main = "Main"

    case picker = "Picker"
    
    case record = "Record"
    
    case community = "Community"
}

extension UIStoryboard {

    static var main: UIStoryboard { return storyBoard(name: StoryboardCategory.main.rawValue) }

    static var picker: UIStoryboard { return storyBoard(name: StoryboardCategory.picker.rawValue) }
    
    static var record: UIStoryboard { return storyBoard(name: StoryboardCategory.record.rawValue) }

    static var community: UIStoryboard { return storyBoard(name: StoryboardCategory.community.rawValue) }

    private static func storyBoard(name: String) -> UIStoryboard {

        return UIStoryboard(name: name, bundle: nil)
    }
}
