//
//  DetailViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/21.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet weak var detailImageView: UIImageView! {
        
        didSet {
            
            detailImageView.image = UIImage.asset(.loading)
            
            detailImageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var favouriteButton: UIButton! {
        
        didSet {
            
            favouriteButton.cornerRadius = 10
            
            favouriteButton.setTitle("", for: .normal)
                        
//            favouriteButton.setBackgroundImage(UIImage.init(systemName: "heart.circle"), for: .normal)
            
            favouriteButton.backgroundColor = .tintColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
