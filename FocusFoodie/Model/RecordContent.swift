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

//    func cellForIndexPath(_ indexPath: IndexPath, tableView: UITableView, data: Product) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier(), for: indexPath)
//
//        guard let basicCell = cell as? ProductBasicCell else { return cell }
//
//        switch self {
//
//        case .description:
//
//            basicCell.layoutCell(product: data)
//
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
}
