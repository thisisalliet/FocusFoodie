//
//  ContentEditViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit

private struct Segue {
        
    static let timeEditor = "SegueTime"
}

class ContentEditViewController: BaseViewController,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegate,
                                 UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView! {
        
        didSet {
            
            categoryCollectionView.delegate = self
            
            categoryCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var saveButtonBackground: UIView! {
        
        didSet {
            
            saveButtonBackground.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var toTimerEditorButton: UIButton!
    
    let category = Category.allCases
    
    var hiddenMinutes: Int?
    
    var categoryObject: [CategoryObject] = []
    
    var categoryHandler: ((_ title: String, _ image: UIImage) -> Void)?
    
    var contentHandler: ((_ title: String, _ note: String) -> Void)?
    
    var timeHandler: ((_ time: Int) -> Void)?
    
    var recipeHandler: ((_ recipe: Recipe) -> Void)?
        
    var datas: [Category] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let identifier = segue.identifier
        
        if identifier ==  Segue.timeEditor {
            
            guard let timeEditVC = segue.destination as? TimerEditViewController else { return }
            
            timeEditVC.timeHandler = timeHandler
            
            timeEditVC.recipeHandler = recipeHandler
        }
    }
    
    // MARK: - Button Action -
    
    @IBAction func toTimerEdit(_ sender: UIButton) {
        
        contentHandler?(titleTextField.text ?? "", noteTextField.text ?? "")
    }
    
    // MARK: - Private Method -
    
    private func setUpCollectionView() {
        
        categoryCollectionView.registerCellWithNib(
            identifier: String(describing: CategorySelectionCell.self),
            bundle: nil)
        
        categoryCollectionView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - UICollectionView Datasource -
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return category.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: CategorySelectionCell.self),
                for: indexPath
            )
            
            guard let selectionCell = cell as? CategorySelectionCell else { return cell }
            
            let item = category[indexPath.row]
            
            selectionCell.layoutCell(image: item.image, title: item.title)
            
            return selectionCell
        }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cellToDeselect: UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        
        cellToDeselect.contentView.backgroundColor = .G2
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell: UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        
        selectedCell.contentView.backgroundColor = .white
        
        categoryHandler?(category[indexPath.row].title, category[indexPath.row].image ?? UIImage())
    }
}
