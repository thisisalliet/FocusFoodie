//
//  TimerEditViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/26.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

//protocol TimerEditControllerDelegate: AnyObject {
//
//    func dismissEditor(_ controller: TimerEditViewController)
//
//    func timeChange(_ controller: TimerEditViewController)
//}

class TimerEditViewController: UIViewController,
                               UITableViewDataSource,
                               UITableViewDelegate,
                               IngredientSelectionCellDelegate {
    
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
        
//    weak var delegate: TimerEditControllerDelegate?
    
    var db: Firestore!
    
    var ingredientCategory: [IngredientCategory: [IngredientObject]] = [
        .bread: BreadItem.allCases,
        .meat: MeatItem.allCases,
        .vegetable: VegetableItem.allCases,
        .side: SideItem.allCases] {
            
            didSet {
                
                galleryView.layoutIfNeeded()
            }
        }

    var selectedBread: IngredientObject?
    
    var selectedVegatable: IngredientObject?
        
    var selectedMeat: IngredientObject?
    
    var selectedSide: IngredientObject?
    
    var totalTime = 0
    
    var timeHandler: ((_ time: Int) -> ())?
    
    var buttonHandler: ((_ status: ButtonStatus) -> ())?
    
    var breadMin = 0
    
    var vegetableMin = 0
    
    var meatMin = 0
    
    var sideMin = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        isModalInPresentation = true
    }
    
    private func setupTableView() {
        
        ingredientTableView.register(
            IngredientSelectionCell.self,
            forCellReuseIdentifier: String(describing: IngredientSelectionCell.self))
    }
    
    // MARK: - Cell Pass Value -
    
    func getIngredientInfo(_ object: IngredientObject) {
                                
        switch object.type {
            
        case .bread:

            galleryView.breadImage.image = object.image!
            breadMin = object.minute
            totalTime = breadMin + vegetableMin + meatMin + sideMin
            galleryView.minuteLabel.text = String(totalTime)
            selectedBread = object

        case .vegetable:

            galleryView.vegetableImage.image = object.image!
            vegetableMin = object.minute
            totalTime = breadMin + vegetableMin + meatMin + sideMin
            galleryView.minuteLabel.text = String(totalTime)
            selectedVegatable = object

        case .meat:

            galleryView.meatImage.image = object.image!
            meatMin = object.minute
            totalTime = breadMin + vegetableMin + meatMin + sideMin
            galleryView.minuteLabel.text = String(totalTime)
            selectedMeat = object
            
        case .side:

            galleryView.sideImage.image = object.image!
            sideMin = object.minute
            totalTime = breadMin + vegetableMin + meatMin + sideMin
            galleryView.minuteLabel.text = String(totalTime)
            selectedSide = object

        default:
            break
        }
    }
    
    // MARK: - Action -
    @IBAction func onDismiss(_ sender: UIButton) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
        buttonHandler?(.notStarted)
        
//        delegate?.dismissEditor(self)
    }
    
    @IBAction func onDone(_ sender: UIButton) {
        
        let recipe = Recipe(
            bread: selectedBread?.title,
            vegetable: selectedVegatable?.title,
            meat: selectedMeat?.title,
            side: selectedSide?.title,
            focusTime: totalTime,
            recipeId: "default")
        
        RecipeManager.shared.createRecipe(recipe: recipe)
        
        timeHandler?(totalTime)
        
        buttonHandler?(.notStarted)
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ingredientCategory.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let type = IngredientCategory(rawValue: indexPath.row),
              let cell = ingredientTableView.dequeueReusableCell(
                withIdentifier: String(describing: IngredientSelectionCell.self),
                for: indexPath) as? IngredientSelectionCell
                
        else { fatalError("IngredientCell error") }
        
        cell.delegate = self
        
        cell.ingredientObjects = ingredientCategory[type]!
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard ingredientTableView.dequeueReusableCell(
            withIdentifier: String(describing: IngredientSelectionCell.self),
            for: indexPath) is IngredientSelectionCell
                
        else { fatalError("SelectionCell error") }
    }
    
    // MARK: - UITableViewDelegate -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
