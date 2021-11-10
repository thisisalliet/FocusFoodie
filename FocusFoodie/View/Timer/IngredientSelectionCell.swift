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

class IngredientSelectionCell: BasicSelectionCell {
    
    weak var delegate: TimerEditViewController?
    
    var selectedIngredientObject: IngredientObject?
    
    var touchHandler: ((IndexPath) -> Void)?
    
    var ingredientObjects: [IngredientObject] = [] {
        
        didSet {
            ingredientCollectionView.reloadData()
        }
    }
    
    var selectedIngredient: [IngredientCategory: IngredientObject] = [:] {
        
        didSet {
            
            ingredientCollectionView.reloadData()
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
                        
        ingredientCollectionView.backgroundColor = .white
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

        switch self.ingredientObjects.first?.type {
            
        case .bread:
            
            delegate?.galleryView.breadImage.image = ingredientObjects[indexPath.row].image!
            
        case .vegetable:
            
            delegate?.galleryView.vegetableImage.image = ingredientObjects[indexPath.row].image!
            
        case .meat:
            
            delegate?.galleryView.meatImage.image = ingredientObjects[indexPath.row].image!

        case .side:
            
            delegate?.galleryView.sideImage.image = ingredientObjects[indexPath.row].image!
            
        default:
            break
        }
        
        //        guard touchHandler?(ingredientObjects[indexPath.row].minute ?? 0) == true else { return }
        //
        //        for (index, object) in ingredientObjects.enumerated() where object.status == .selected {
        //
        //            ingredientObjects[index].status = .avaliable
        //        }
        //
        //        ingredientObjects[indexPath.row].status = .selected
        //
 
        //
        //        ingredientObjects[indexPath.row].isSelected = !ingredientObjects[indexPath.row].isSelected
        //
//        touchHandler?(indexPath)
        
//        ingredientCollectionView.reloadData()
        
        
        
        
//        delegate?.galleryView.knifeImage
        
        
        
        
    }
}
