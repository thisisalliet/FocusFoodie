//
//  IngredientSelectionCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit

enum SelectedStatus {
    
    case selected
    
    case disable
}

struct SelectedItem {
    
    let type: IngredientCategory
    
    let image: UIImage

    let title: String

    let minute: Int
    
    var status: SelectedStatus
}

protocol IngredientSelectionCellDelegate: AnyObject {
    
    func getIngredientInfo(_ object: IngredientObject)
}

class IngredientSelectionCell: TimerBasicCell {
    
    weak var delegate: IngredientSelectionCellDelegate?
    
    var selectedIngredientObject: IngredientObject?
    
    var touchHandler: ((IndexPath) -> Void)?
    
    var ingredientObjects: [IngredientObject] = [] {
        
        didSet {
            
//            ingredientCollectionView.reloadData()
        }
    }
    
    var selectedIngredient: [IngredientCategory: IngredientObject] = [:] {
        
        didSet {
            
//            ingredientCollectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupiIngredientView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupiIngredientView()
    }
    
    private func setupiIngredientView() {
                        
        ingredientCollectionView.backgroundColor = .clear
    }
    
    
    override func numberOfItem(_ cell: TimerBasicCell) -> Int {
        
        return ingredientObjects.count
    }
    
    override func viewIn(_ cell: TimerBasicCell, selectionCell: SelectionCell, indexPath: IndexPath) {
        
        guard (selectionCell.objectView as? IngredientItemView) != nil else {
            
            let ingredientView = IngredientItemView()
            
            ingredientView.layoutCell(
                image: ingredientObjects[indexPath.row].image!,
                title: ingredientObjects[indexPath.row].title,
                minute: ingredientObjects[indexPath.row].minute,
                isSelected: false)
            
            selectionCell.objectView = ingredientView
            
            return
        }
    }
    
    override func didSelected(_ cell: TimerBasicCell, at indexPath: IndexPath) {

        delegate?.getIngredientInfo(ingredientObjects[indexPath.row])
    }
}
