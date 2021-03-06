//
//  IngredientContentCategory.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/1.
//

import UIKit

protocol SelectionCellDataSource: AnyObject {

    func numberOfItem(_ cell: TimerBasicCell) -> Int

    func viewIn(_ cell: TimerBasicCell, selectionCell: SelectionCell, indexPath: IndexPath)

    func didSelected(_ cell: TimerBasicCell, at indexPath: IndexPath)
}

class TimerBasicCell: UITableViewCell,
                       UICollectionViewDataSource,
                       UICollectionViewDelegate,
                       SelectionCellDataSource {

    lazy var ingredientCollectionView: UICollectionView = {

        let layoutObject = UICollectionViewFlowLayout()

        layoutObject.itemSize = CGSize(width: UIScreen.width / 3.5, height: 150)

        layoutObject.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        layoutObject.minimumLineSpacing = 8.0

        layoutObject.minimumInteritemSpacing = 0

        layoutObject.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layoutObject)

        collectionView.backgroundColor = .clear
        
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.dataSource = self

        collectionView.delegate = self

//        addSubview(collectionView)
        insertSubview(collectionView, aboveSubview: contentView) // resolved temporally
//        contentView.addSubview(collectionView) //
        return collectionView

    }()

    weak var dataSource: SelectionCellDataSource?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initView()
    }

    private func initView() {

        setupCollectionView()
        
        dataSource = self
        
        backgroundColor = .G1

        selectionStyle = .default
    }

    private func setupCollectionView() {

        ingredientCollectionView.translatesAutoresizingMaskIntoConstraints = false

        ingredientCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0).isActive = true

        ingredientCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true

        ingredientCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16.0).isActive = true

        let bottomConstraint = ingredientCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)

        bottomConstraint.priority = .defaultHigh

        bottomConstraint.isActive = true

        ingredientCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        ingredientCollectionView.register(
            SelectionCell.self,
            forCellWithReuseIdentifier: String(describing: SelectionCell.self))
    }

    func reloadData() {

        ingredientCollectionView.reloadData()
    }

    // MARK: - SelectionCellDataSource -

    func numberOfItem(_ cell: TimerBasicCell) -> Int {

        return 0
    }

    func viewIn(_ cell: TimerBasicCell, selectionCell: SelectionCell, indexPath: IndexPath) {

    }

    func didSelected(_ cell: TimerBasicCell, at indexPath: IndexPath) {

    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.dataSource?.numberOfItem(self) ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: SelectionCell.self),
            for: indexPath
        )

        guard let selectionCell = cell as? SelectionCell else { return cell }

        dataSource?.viewIn(self, selectionCell: selectionCell, indexPath: indexPath)

        return selectionCell
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        dataSource?.didSelected(self, at: indexPath)
    }
}

class SelectionCell: UICollectionViewCell {

    var objectView: UIView! {

        didSet {
            
            stickSubView(objectView)
        }
    }

}
