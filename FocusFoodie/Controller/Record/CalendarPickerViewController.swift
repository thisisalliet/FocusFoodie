//
//  CalendarPickerViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/21.
//

import UIKit

class CalendarPickerViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.minimumLineSpacing = 0
      layout.minimumInteritemSpacing = 0
        
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.isScrollEnabled = false
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .systemGroupedBackground
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            //1
            collectionView.leadingAnchor.constraint(
                equalTo: view.readableContentGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(
                equalTo: view.readableContentGuide.trailingAnchor),
            //2
            collectionView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor,
                constant: 10),
            //3
            collectionView.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 0.5)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
