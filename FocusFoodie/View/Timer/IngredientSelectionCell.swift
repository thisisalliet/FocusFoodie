//
//  IngredientSelectionCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit

class IngredientSelectionCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var ingredients: [String] = [] {
        
        didSet {
            
            ingredientCollectionView?.reloadData()
        }
    }
    
    var ingredientTableView = IngredientSelectionCell?.self
    
    @IBOutlet weak var ingredientCollectionView: UICollectionView! {
        
        didSet {
            
            ingredientCollectionView.registerCellWithNib(
                identifier: String(describing: IngredientCollectionViewCell.self),
                bundle: nil)
                                    
            ingredientCollectionView?.dataSource = self
            
            ingredientCollectionView?.delegate = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
//        return ingredients.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: IngredientCollectionViewCell.self), for: indexPath)
        
//            cell.layer.borderWidth = 1.5
        
//        cell.layer.borderColor = UIColor.B5?.cgColor
            
        cell.backgroundColor = .B1
        
        cell.cornerRadius = 10
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        return CGSize(width: UIScreen.width / 5.0, height: 100)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {

        return UIEdgeInsets(top: 16.0, left: 16.0, bottom: 8.0, right: 16.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {

        return 24.0
    }
}
