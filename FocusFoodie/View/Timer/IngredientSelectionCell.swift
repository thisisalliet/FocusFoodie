//
//  IngredientSelectionCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit

enum IngredientStatus {
    
    case avaliable

    case selected

    case disable
}

class IngredientSelectionCell: BasicSelectionCell {
    
    var ingredientObjects: [IngredientObject] = [] {

        didSet {
            ingredientCollectionView.reloadData()
        }
    }
    
    var touchHandler: ((Int) -> Bool)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupiIngredientView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupiIngredientView()
    }

    private func setupiIngredientView() {
        
        ingredientCollectionView.backgroundColor = .B1
    }
    
    override func numberOfItem(_ cell: BasicSelectionCell) -> Int {
        
        return ingredientObjects.count
    }
    
    override func viewIn(_ cell: BasicSelectionCell, selectionCell: SelectionCell, indexPath: IndexPath) {
        
        guard (selectionCell.objectView as? IngredientItemView) != nil else {

            let ingredientView = IngredientItemView()

            ingredientView.layoutCell(image: ingredientObjects[indexPath.row].image!,
                                      title: ingredientObjects[indexPath.row].title!,
                                      minute: ingredientObjects[indexPath.row].minute!,
                                      isSelected: false)

            selectionCell.objectView = ingredientView

            return
        }
    }
    
    override func didSelected(_ cell: BasicSelectionCell, at indexPath: IndexPath) {
        
        guard touchHandler?(ingredientObjects[indexPath.row].minute ?? 0) == true else { return }
        
        for (index, object) in ingredientObjects.enumerated() where object.status == .selected {

            ingredientObjects[index].status = .avaliable
        }
//
//        ingredientObjects[indexPath.row].status = .selected
//
//        ingredientCollectionView.reloadData()
        
//        for index in 0 ..< ingredientObjects.count {
//
//            ingredientObjects[index].isSelected = false
//        }
//
//        ingredientObjects[indexPath.row].isSelected = !ingredientObjects[indexPath.row].isSelected
//
//        touchHandler?(indexPath)
//
//        ingredientCollectionView.reloadData()
    }
}
