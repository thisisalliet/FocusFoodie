//
//  ContentEditViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit

private struct Segue {
    
    //    static let contentEditor = "SegueContent"
    
    static let timeEditor = "SegueTime"
}

class ContentEditViewController: BaseViewController,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegate,
                                 UICollectionViewDelegateFlowLayout{
    
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
    
    var categoryObject: [CategoryItem] = []
    
    var categoryHandler: ((_ title: String, _ image: UIImage) -> Void)?
    
    var contentHandler: ((_ title: String, _ note: String) -> Void)?
    
    var timeHandler: ((_ time: Int) -> ())?
        
    var datas: [Category] = []
    
    //    weak var delegate: ContentEditViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let identifier = segue.identifier
        
        if identifier ==  Segue.timeEditor {
            
            guard let timeEditVC = segue.destination as? TimerEditViewController else { return }
            
            timeEditVC.timeHandler = timeHandler
        }
    }
    
    // MARK: - Button Actions -
    
    @IBAction func toTimerEdit(_ sender: UIButton) {
        
        contentHandler?(titleTextField.text ?? "", noteTextField.text ?? "")
    }
    
    func setUpCollectionView() {
        
        //        let layoutObject = UICollectionViewFlowLayout()
        //
        //        layoutObject.itemSize = CGSize(width: UIScreen.width / 4.0, height: 60)
        //
        //        layoutObject.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        //        layoutObject.minimumLineSpacing = 8.0
        //
        //        layoutObject.minimumInteritemSpacing = 0
        //
        //        layoutObject.scrollDirection = .horizontal
        //
        
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

//extension ContentEditViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//
//            return CGSize(width: UIScreen.width / 5.0, height: 60.0)
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        insetForSectionAt section: Int
//    ) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumLineSpacingForSectionAt section: Int
//    ) -> CGFloat {
//
//        return 8.0
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumInteritemSpacingForSectionAt section: Int
//    ) -> CGFloat {
//
//        return 0
//    }
//}
