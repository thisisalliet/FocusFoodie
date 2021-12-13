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

protocol TimerEditDelegate: AnyObject {
    
    func passTime(minutes: Int)
}

class TimerEditViewController: BaseViewController,
                               UITableViewDataSource,
                               UITableViewDelegate,
                               IngredientSelectionCellDelegate {
    
    @IBOutlet weak var crossBackground: UIView! {
        
        didSet {
            
            crossBackground.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var crossButton: UIButton!
    
    @IBOutlet weak var checkBackground: UIView! {
        
        didSet {
            
            checkBackground.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var galleryView: IngredientGalleryView!
    
    @IBOutlet weak var ingredientTableView: UITableView! {
        
        didSet {
            
            ingredientTableView.separatorStyle = .none
            
            ingredientTableView.dataSource = self
            
            ingredientTableView.delegate = self
        }
    }
    
    weak var delegate: TimerEditDelegate?
    
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
    
    var timeHandler: ((_ time: Int) -> Void)?
    
    var recipeHandler: ((_ recipe: Recipe) -> Void)?
    
    var buttonHandler: ((_ status: ButtonStatus) -> Void)?
    
    var breadMin = 0
    
    var vegetableMin = 0
    
    var meatMin = 0
    
    var sideMin = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: - Button Action -
    
    @IBAction func onDismiss(_ sender: UIButton) {
                
        buttonHandler?(.notStarted)
                
        backToTimer()
    }
    
    @IBAction func onDone(_ sender: UIButton) {
        
        let recipe = Recipe(
            bread: selectedBread?.title,
            vegetable: selectedVegatable?.title,
            meat: selectedMeat?.title,
            side: selectedSide?.title,
            focusTime: totalTime,
            recipeId: "default")

        RecipeManager.shared.createRecipe(recipe: recipe) { result in
            switch result {
            case .success(let recipeWithId):
                self.recipeHandler?(recipeWithId)
            case .failure(let error):
                print(error)
            }
        }
                
        timeHandler?(totalTime)
                
        buttonHandler?(.notStarted)
                
        backToTimer()
    }
    
    // MARK: - Private Function -
    
    private func setupTableView() {
        
        ingredientTableView.register(
            IngredientSelectionCell.self,
            forCellReuseIdentifier: String(describing: IngredientSelectionCell.self))
    }
    
    // MARK: - Public Method -
    
    func getIngredientInfo(_ object: IngredientObject) {
                                
        switch object.type {
            
        case .bread:

            galleryView.breadImage.image = object.image ?? UIImage()
            breadMin = object.minute
            totalTime = breadMin + vegetableMin + meatMin + sideMin
            galleryView.totalMinuteLabel.text = String(totalTime)
            selectedBread = object

        case .vegetable:

            galleryView.vegetableImage.image = object.image ?? UIImage()
            vegetableMin = object.minute
            totalTime = breadMin + vegetableMin + meatMin + sideMin
            galleryView.totalMinuteLabel.text = String(totalTime)
            selectedVegatable = object

        case .meat:

            galleryView.meatImage.image = object.image ?? UIImage()
            meatMin = object.minute
            totalTime = breadMin + vegetableMin + meatMin + sideMin
            galleryView.totalMinuteLabel.text = String(totalTime)
            selectedMeat = object
            
        case .side:

            galleryView.sideImage.image = object.image ?? UIImage()
            sideMin = object.minute
            totalTime = breadMin + vegetableMin + meatMin + sideMin
            galleryView.totalMinuteLabel.text = String(totalTime)
            selectedSide = object
        }
    }
    
    func backToTimer() {
        
        if let presentingViewController = presentingViewController?.presentingViewController {
            
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - UITableView DataSource -
    
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
        
        cell.ingredientObjects = ingredientCategory[type] ?? []
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard ingredientTableView.dequeueReusableCell(
            withIdentifier: String(describing: IngredientSelectionCell.self),
            for: indexPath) is IngredientSelectionCell
                
        else { fatalError("SelectionCell error") }
    }
    
    // MARK: - UITableView Delegate -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 170
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
