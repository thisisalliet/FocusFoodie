//
//  RecordContent.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import Foundation

enum RecordContent: String {

    case image

    case select

    case description

    func identifier() -> String {

        switch self {

        case .image: return String(describing: DetailImageTableViewCell.self)

        case .select: return String(describing: DetailInfoTableViewCell.self)

        case .description: return String(describing: DetailNoteTableViewCell.self)

        }
    }
}
