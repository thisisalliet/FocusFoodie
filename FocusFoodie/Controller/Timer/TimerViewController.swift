//
//  PickerViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class TimerViewController: BaseViewController {
    
    var timerEditViewController = TimerEditViewController
    
    @IBOutlet weak var cookingImageView: UIImageView! {
        
        didSet {
            
            cookingImageView.image = .asset(.icon_loading)
            
        }
    }
    
    @IBOutlet weak var countDownLabel: UILabel! {
        
        didSet {
            
            countDownLabel.text = "3:00:00"
            
            countDownLabel.textColor = .B5
                        
            countDownLabel.font = .medium(size: 40)
        }
    }
    
    @IBOutlet weak var doneButton: UIButton! {
        
        didSet {
            
            doneButton.setTitle("Done", for: .normal)
            
            doneButton.setTitleColor(.white, for: .normal)
            
            doneButton.backgroundColor = .B6
        }
    }
    
    @IBOutlet weak var controlButton: UIButton! {
        
        didSet {
            
            controlButton.setTitle("Start", for: .normal)
            
            controlButton.setTitleColor(.white, for: .normal)
            
            controlButton.backgroundColor = .B6
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cookingImageView.isUserInteractionEnabled = true
        
        cookingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapCookingimage)))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didTapDoneBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapControlBtn(_ sender: UIButton) {
        
    }
    
    @objc func didTapCookingimage() {
        
        self.present(TimerEditViewController())
    }
}
