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
    
    var db: Firestore!
    
    var ingredientCategory: [IngredientCategory: [IngredientObject]] = [
        .bread: BreadItem.allCases,
        .meat: MeatItem.allCases,
        .vegetable: VegetableItem.allCases,
        .side: SideItem.allCases
    ]
    
    private let selectedCategory: [IngredientCategory] = [.bread, .meat, .vegetable, .side]

    var selectedBread: BreadItem? {
        
        didSet {
            
            guard let index = selectedCategory.firstIndex(of: .bread) else { return }
            
            let indexPath = IndexPath(row: index, section: 0)
            
            guard let cell = ingredientTableView.cellForRow(at: indexPath) else { return }
            
            delegate?.timeChange(self)
        }
    }
    
    var selectedVegatable: VegetableItem? {

        didSet {

            guard let index = selectedCategory.firstIndex(of: .vegetable) else { return }

            let indexPath = IndexPath(row: index, section: 0)

            guard let cell = ingredientTableView.cellForRow(at: indexPath) else { return }

            delegate?.timeChange(self)
        }
    }
        
    var selectedMeat: MeatItem? {
        
        didSet {

            guard let index = selectedCategory.firstIndex(of: .meat) else { return }

            let indexPath = IndexPath(row: index, section: 0)

            guard let cell = ingredientTableView.cellForRow(at: indexPath) else { return }

            delegate?.timeChange(self)
        }
    }
    
    var selectedSide: SideItem? {
        
        didSet {

            guard let index = selectedCategory.firstIndex(of: .side) else { return }

            let indexPath = IndexPath(row: index, section: 0)

            guard let cell = ingredientTableView.cellForRow(at: indexPath) else { return }

            delegate?.timeChange(self)
        }
    }
    
    var totalTime = 50
    
    //    var selectedIngredient: IngredientObject?
    
    var selectedIngredient: [IngredientCategory: IngredientObject] = [:]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        isModalInPresentation = true
    }
    
    private func setupTableView() {
        
        ingredientTableView.register(IngredientSelectionCell.self,
                                     forCellReuseIdentifier: String(describing: IngredientSelectionCell.self))
    }
    
    // MARK: - Action -
    @IBAction func onDismiss(_ sender: UIButton) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
        delegate?.dismissEditor(self)
    }
    
    @IBAction func onDone(_ sender: UIButton) {
        
        let id = db.collection(CollectionName.recipe.rawValue).document().documentID
        
        let recipe = Recipe(bread: "test",
                            vegetable: "test",
                            meat: "test",
                            side: "test",
                            focusTime: Int64(totalTime),
                            recipeId: id)
        
        do {
            try db.collection(CollectionName.recipe.rawValue).document(id).setData(from: recipe)
            
        } catch let error {
            
            print(error)
        }
    }
    
    // MARK: - Cell Arrangement
    private func manipulaterCell(_ view: IngredientGalleryView, type: IngredientCategory) {

        switch type {

        case .bread:

            updateBreadImage(view)

        case .vegetable:

            updateVegetableImage(view)

        case .meat:

            updateVegetableImage(view)
            
        case .side:
            
            updateSideImage(view)
        }
    }
    
    private func updateBreadImage(_ view: IngredientGalleryView) {
        
//         let breadImage = view as? IngredientGalleryView
//        let ingredientObject = IngredientObject.self
//
//        breadImage.touchHandler = { [weak self] indexPath in
//
//            self?.selectedBread = self?.ingredientCategory?.index(forKey: .bread).[indexPath.row]
//        }
    }
    
    private func updateVegetableImage(_ view: IngredientGalleryView) {
        
    }
    
    private func updateMeatImage(_ view: IngredientGalleryView) {
        
    }
    
    private func updateSideImage(_ view: IngredientGalleryView) {
        
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
        else { fatalError("IngredientCell error") }
        
        cell.delegate = self
        cell.ingredientObjects = ingredientCategory[type]!
//        cell.selectedIngredientObject = selectedIngredient[type]!
        
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
