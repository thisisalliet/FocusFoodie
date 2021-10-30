//
//  IngredientSelectionCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit

class IngredientSelectionCell: UITableViewCell,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {
    
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
    
//    private func showIngredientInGallery(ingredient: Ingredient) {
//
//        let productDetailVC = UIStoryboard.product.instantiateViewController(withIdentifier:
//            String(describing: ProductDetailViewController.self)
//        )
//
//        guard let detailVC = productDetailVC as? ProductDetailViewController else { return }
//
//        detailVC.product = product
//
//        show(detailVC, sender: nil)
//    }
    
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
            
        cell.backgroundColor = .B1
        
        cell.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        ingredientCollectionView.deselectItem(at: indexPath, animated: true)
        
//        guard let ingredient = datas[indexPath.section][indexPath.row] as? Ingredient else { return }
        
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        return CGSize(width: UIScreen.width / 4.0, height: 190)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}
