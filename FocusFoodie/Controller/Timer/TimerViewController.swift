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
    
    var counter = 0
    
    var startStatus = true
    
    var pauseStatus = false
    
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
            
            doneButton.layer.cornerRadius = doneButton.frame.width / 2
        }
    }
    
    @IBOutlet weak var controlButton: UIButton! {
        
        didSet {
            
            controlButton.setTitle("Start", for: .normal)
            
            controlButton.setTitleColor(.white, for: .normal)
            
            controlButton.backgroundColor = .B6
            
            controlButton.layer.cornerRadius = controlButton.frame.width / 2
        }
    }
    
    @IBAction func didTapDoneBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapControlButton(_ sender: UIButton) {
        
        counter += 1
        
        switch counter {
            
        case 1:
            controlButton.setTitle("Start", for: .normal)
            
        case 2:
            controlButton.setTitle("Pause", for: .normal)
            
        case 3:
            controlButton.setTitle("Resume", for: .normal)
            
        default:
            print("Unable to change button title text.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//        if startStatus {
//
//            startStatus = false
//                    controlButton.setTitleColor(.white, for: .normal)
//            controlButton.setTitle("Cancel", for: .normal)
//
//                    countdownTimer.isHidden = true
//                    timerLabel.isHidden = false
//
//                    pauseStatus = true
//                    pauseBtn.setTitleColor(.white, for: .normal)
//                    pauseBtn.setTitle("Pause", for: .normal)
//                    pauseBtn.isEnabled = true
//        }else{
//
//                    startStatus = true
//                    startBtn.setTitleColor(.white, for: .normal)
//                    startBtn.setTitle("Start", for: .normal)
//
//                    countdownTimer.isHidden = false
//                    timerLabel.isHidden = true
//
//                    pauseStatus = false
//                    pauseBtn.isEnabled = false
//                    pauseBtn.setTitleColor(.lightGray, for: .normal)
//        }
