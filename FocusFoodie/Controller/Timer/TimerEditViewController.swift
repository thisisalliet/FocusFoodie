//
//  TimerEditViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

protocol TimerEditControllerDelegate: AnyObject {

    func dismissEditor(_ controller: TimerEditViewController)

    func timeChange(_ controller: TimerEditViewController)
}

class TimerEditViewController: UIViewController,
                                UITableViewDataSource,
                                UITableViewDelegate {
    
    var ingredientCategory: [IngredientCategory: [IngredientObject]] = [
        .bread: BreadItem.allCases,
        .meat: MeatItem.allCases,
        .vegetable: VegetableItem.allCases,
        .side: SideItem.allCases
    ]
    
    weak var delegate: TimerEditControllerDelegate?
    
    @IBOutlet weak var crossButton: UIButton!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var galleryView: IngredientGalleryView!
    
    @IBOutlet weak var ingredientTableView: UITableView! {
        
        didSet {
            
            ingredientTableView.separatorStyle = .none
            
            ingredientTableView.dataSource = self
            
            ingredientTableView.delegate = self
        }
    }
    
    @IBAction func onDismiss(_ sender: UIButton) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
        delegate?.dismissEditor(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupTableView()
    }
    
    private func setupTableView() {
        
        ingredientTableView.register(IngredientSelectionCell.self,
                                     forCellReuseIdentifier: String(describing: IngredientSelectionCell.self))
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
