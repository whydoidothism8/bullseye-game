//
//  ViewController.swift
//  dandikbirapp2
//
//  Created by Noyan on 17.03.19.
//  Copyright © 2019 nalsnaraak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userRequest: UILabel!
    @IBOutlet weak var guessCosmetic: UISlider!
    @IBOutlet weak var exactMode: UISwitch!
    @IBOutlet weak var guessResult: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    var inputNum:Float = 0
    var randNum:Float = 0
    var checkAgain:Bool = false
    var tempScore:Int = 0
    var highScore:Int = UserDefaults.standard.integer(forKey: "HighScore")
    override func viewDidLoad() {
        super.viewDidLoad()
        randNum = Float(arc4random_uniform(101))
        userRequest.text = "Move the slider to \(randNum)"
        guessResult.isHidden = true
    }
    
    @IBAction func guessNum(_ sender: UISlider) {
        inputNum = sender.value
    }
    
    func guessTrue() {
        guessResult.textAlignment = .center
        guessResult.text = "The slider matched!Bullseye"
        guessResult.backgroundColor = UIColor.green
        guessResult.isHidden = false
        tempScore += 1
    }
    func guessFalse(){
        guessResult.textAlignment = .center
        guessResult.text = "Whoops!You missed!Score:\(tempScore)"
        guessResult.backgroundColor = UIColor.red
        guessResult.isHidden = false
        tempScore = 0
    }
    
    @IBAction func checkGuess(_ sender: Any) {
        if checkAgain == true {
            checkButton.setTitle("Check?", for: .normal)
            guessCosmetic.setValue(50.0, animated:false)
            randNum = Float(arc4random_uniform(101))
            userRequest.text = "Move the slider to \(randNum)"
            guessResult.isHidden = true
            checkButton.setTitle("Check?", for: .normal)
            checkAgain = false
        }
        else{
            checkAgain = true
            checkButton.setTitle("Try again?", for: .normal)
            if exactMode.isOn == true{
                if inputNum == randNum{
                    guessTrue()
                }
                else{
                    guessFalse()
                }
            }
            else{
                if Float(inputNum._value) >= randNum - 3.0 && Float(inputNum._value) <= randNum + 3{
                    guessTrue()
                }
                else{
                    guessFalse()
                }
            }
        }

        if tempScore >= highScore{
            highScore = UserDefaults.standard.integer(forKey: "HighScore")
            highScore = tempScore
            UserDefaults.standard.set(highScore, forKey: "HighScore")
            UserDefaults.standard.synchronize()
            
        }
        
    }
    @IBAction func scorePopUp(_ sender: Any) {
        let alertController = UIAlertController(title: "Score", message: "Your highscore:\(highScore)", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
}
