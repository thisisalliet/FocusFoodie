//
//  TimerEditViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class TimerEditViewController: UIViewController,
                                UITableViewDataSource,
                                UITableViewDelegate {
    
    @IBOutlet weak var dismissButton: UIButton! {
        
        didSet {
            
            dismissButton.setTitle("", for: .normal)
            
//            dismissButton.backgroundImage(for: .normal) = .asset(.)
        }
    }
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var galleryView: IngredientView! {
        
        didSet {
            
            galleryView.frame.size.height = CGFloat(Int(UIScreen.height * 1 / 3))
        }
    }
    
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
            String(describing: IngredientSelectionCell.self),
                                         bundle: nil
        )
    }
    
    // MARK: - UITableViewDataSource -

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            guard let breadCell = ingredientTableView.dequeueReusableCell(withIdentifier:
                String(describing: IngredientSelectionCell.self),
                for: indexPath) as? IngredientSelectionCell
            else { fatalError("BreadCell error") }
            
            return breadCell
            
        case 1:
            guard let sideCell = ingredientTableView.dequeueReusableCell(withIdentifier:
                String(describing: IngredientSelectionCell.self),
                for: indexPath) as? IngredientSelectionCell
            else { fatalError("SideCell error") }
            
            return sideCell
            
        case 2:
            guard let veggieCell = ingredientTableView.dequeueReusableCell(withIdentifier:
                String(describing: IngredientSelectionCell.self),
                for: indexPath) as? IngredientSelectionCell
            else { fatalError("VeggieCell error") }
            
            return veggieCell
            
        case 3:
            guard let meatCell = ingredientTableView.dequeueReusableCell(withIdentifier:
                String(describing: IngredientSelectionCell.self),
                for: indexPath) as? IngredientSelectionCell
            else { fatalError("MeatCell error") }
            
            return meatCell
        
        default:
            return IngredientSelectionCell()
        }
    }
    
    // MARK: - UITableViewDelegate -

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
