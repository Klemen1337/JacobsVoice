//
//  ViewController.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 17/05/15.
//  Copyright (c) 2015 Klemen Kastelic. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var categoryButtons: [UIButton]!
    @IBOutlet var bottomButtons: [UIButton]!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var textField: UITextField!
    var speechHelper = SpeechHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryButtonsTitles(CATEGORIES)
        setEmotions(EMOTIONS_MAIN, bottomButtonsArray: EMOTIONS_JOINTS)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ClearButtonClicked(sender: AnyObject) {
        textField.text = ""
    }
    
    @IBAction func SpeakButtonClicked(sender: AnyObject) {
        speechHelper.say(textField.text)
        textField.text = ""
    }
    
    @IBAction func buttonClicked(sender: AnyObject) {
        var button:UIButton = sender as! UIButton
        appendText(sender.titleLabel!!.text!)
    }
    
    @IBAction func buttonCategoryClicked(sender: AnyObject) {
        var button:UIButton = sender as! UIButton
        switch(sender.titleLabel!!.text!){
            case "Emotions":
                setEmotions(EMOTIONS_MAIN, bottomButtonsArray: EMOTIONS_JOINTS)
                break
            case "Food":
                setEmotions(FOOD_MAIN, bottomButtonsArray: FOOD_MAIN_JOINTS)
                break
            case "Friends":
                setEmotions(FRIENDS_MAIN, bottomButtonsArray: FRIENDS_JOINTS)
                break
            case "Places":
                setEmotions(PLACES_MAIN, bottomButtonsArray: PLACES_JOINTS)
                break
            case "School":
                setEmotions(SCHOOL_MAIN, bottomButtonsArray: SCHOOL_JOINTS)
                break
            default:
                break
        }
    }
    
    
    func appendText(text:String) {
        textField.text = textField.text + text + " "
    }
    
    func setEmotions(emotions:NSArray, bottomButtonsArray:NSArray){
        setBottomButtonsTitles(bottomButtonsArray)
        setMainButtons(emotions)
    }
    
    func setBottomButtonsTitles(bottomButtonsArray:NSArray){
        for (index, title) in enumerate(bottomButtonsArray){
            bottomButtons[index].setTitle(title as? String, forState: UIControlState.Normal)
        }
    }
    
    func setMainButtons(emotions:NSArray){
        for (index, title) in enumerate(emotions){
            buttons[index].setTitle(title as? String, forState: UIControlState.Normal)
        }
    }
    
    func setCategoryButtonsTitles(categoryButtonTitles:NSArray){
        for (index, title) in enumerate(categoryButtonTitles){
            categoryButtons[index].setTitle(title as? String, forState: UIControlState.Normal)
        }
    }
}

