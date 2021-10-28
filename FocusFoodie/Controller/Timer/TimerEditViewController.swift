//
//  TimerEditViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class TimerEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ingredientTableView: UITableView! {
        
        didSet {
            
            ingredientTableView.separatorStyle = .none
            
            ingredientTableView.dataSource = self
            
            ingredientTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {

        ingredientTableView.registerCellWithNib(identifier:
            String(describing: IngredientImageCell.self),
                                         bundle: nil
        )

        ingredientTableView.registerCellWithNib(identifier:
            String(describing: IngredientSelectionCell.self),
                                         bundle: nil
        )
    }
    
    // MARK: - UITableViewDataSource -

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            guard let imageCell = ingredientTableView.dequeueReusableCell(withIdentifier:
                String(describing: IngredientImageCell.self),
                for: indexPath) as? IngredientImageCell
            else { fatalError("IngredientImageCell error") }
            
            return imageCell
            
        case 1:
            guard let breadCell = ingredientTableView.dequeueReusableCell(withIdentifier:
                String(describing: IngredientSelectionCell.self),
                for: indexPath) as? IngredientSelectionCell
            else { fatalError("BreadCell error") }
            
            return breadCell
            
        case 2:
            guard let sideCell = ingredientTableView.dequeueReusableCell(withIdentifier:
                String(describing: IngredientSelectionCell.self),
                for: indexPath) as? IngredientSelectionCell
            else { fatalError("SideCell error") }
            
            return sideCell
            
        case 3:
            guard let veggieCell = ingredientTableView.dequeueReusableCell(withIdentifier:
                String(describing: IngredientSelectionCell.self),
                for: indexPath) as? IngredientSelectionCell
            else { fatalError("VeggieCell error") }
            
            return veggieCell
            
        case 4:
            guard let meatCell = ingredientTableView.dequeueReusableCell(withIdentifier:
                String(describing: IngredientSelectionCell.self),
                for: indexPath) as? IngredientSelectionCell
            else { fatalError("MeatCell error") }
            
            return meatCell
        
        default:
            return IngredientImageCell()
        }
    }
    
    // MARK: - UITableViewDelegate -

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return 300
            
        case 1, 2, 3, 4:
            return 130
            
//        case 2:
//            return 130
//
//        case 3:
//            return 130
//
//        case 4:
//            return 130
            
        default:
            return 130
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
