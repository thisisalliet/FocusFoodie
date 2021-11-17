//
//  ContentEditViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/17.
//

import UIKit

class ContentEditViewController: UIViewController,
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
    
    @IBOutlet weak var saveButton: UIButton! {
        
        didSet {
            
            saveButton.layer.cornerRadius = 10
        }
    }
    
    let category = Category.allCases
    
    var categoryObject: [CategoryItem] = []
    
    var categoryHandler: ((_ title: String, _ image: UIImage) -> ())?
    
    var contentHandler: ((_ title: String, _ note: String) -> ())?
    
    var datas: [Category] = []
    
//    weak var delegate: ContentEditViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
    }
    
    // MARK: - Button Actions -
    
    @IBAction func onSave(_ sender: UIButton) {
        
        contentHandler?(titleTextField.text ?? "", noteTextField.text ?? "")
        
        presentingViewController?.dismiss(animated: true, completion: nil)
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

//        categoryCollectionView.backgroundColor = .Y2

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
    
    // MARK: - UICollectionView Delegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
