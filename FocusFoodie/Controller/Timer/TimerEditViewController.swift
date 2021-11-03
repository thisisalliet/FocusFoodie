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
    
    var ingredientCategory: [IngredientCategory: [IngredientObject]] = [
        .bread: BreadItem.allCases,
        .meat: MeatItem.allCases,
        .vegetable: VegetableItem.allCases,
        .side: SideItem.allCases
    ]
    
    @IBOutlet weak var dismissButton: UIButton! {
        
        didSet {
            
            dismissButton.setTitle("", for: .normal)
            
            dismissButton.setBackgroundImage(.asset(.icon_cross_normal), for: .normal)
        }
    }
    
    @IBOutlet weak var doneButton: UIButton! {
        
        didSet {
            
            doneButton.setTitle("", for: .normal)
            
            doneButton.setBackgroundImage(.asset(.icon_check_normal), for: .normal)
        }
    }
    
    @IBOutlet weak var galleryView: IngredientGalleryView!
//    {
//
//        didSet {
//
//            galleryView.frame.size.height = CGFloat(Int(UIScreen.height * 1 / 3))
//        }
//    }
    
    @IBOutlet weak var ingredientTableView: UITableView! {
        
        didSet {
            
            ingredientTableView.separatorStyle = .none
            
            ingredientTableView.dataSource = self
            
            ingredientTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        galleryView.frame.size.height = CGFloat(Int(UIScreen.height * 1 / 3))
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        ingredientTableView.register(IngredientSelectionCell.self, forCellReuseIdentifier: String(describing: IngredientSelectionCell.self))

//        ingredientTableView.registerCellWithNib(identifier:
//            String(describing: IngredientSelectionCell.self),
//                                         bundle: nil
//        )
    }
    
    // MARK: - UITableViewDataSource -

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ingredientCategory.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let type = IngredientCategory(rawValue: indexPath.row),
              let cell = ingredientTableView.dequeueReusableCell(withIdentifier:
            String(describing: IngredientSelectionCell.self),
            for: indexPath) as? IngredientSelectionCell
        else { fatalError("SideCell error") }
        
        cell.ingredientObjects = ingredientCategory[type]!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard ingredientTableView.dequeueReusableCell(withIdentifier:
            String(describing: IngredientSelectionCell.self),
            for: indexPath) is IngredientSelectionCell
        else { fatalError("SideCell error") }
        
    }
    
    // MARK: - UITableViewDelegate -

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
