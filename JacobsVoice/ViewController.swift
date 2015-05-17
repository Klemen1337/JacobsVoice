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
    
    @IBOutlet weak var autoButton: UIButton!
    @IBOutlet var categoryButtons: [UIButton]!
    @IBOutlet var bottomButtons: [UIButton]!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var textField: UITextField!
    var speechHelper = SpeechHelper()
    var autoSpeak = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryButtonsTitles(CATEGORIES)
        setEmotions(EMOTIONS_MAIN, bottomButtonsArray: EMOTIONS_JOINTS)
		
		for (index, button) in enumerate(buttons){
			var lpgr = UILongPressGestureRecognizer(target: self, action: "longPressed:")
			button.addGestureRecognizer(lpgr)
			button.userInteractionEnabled = true
		}
    }
	
	func longPressed(longPress: UIGestureRecognizer) {
		var inputTextField: UITextField?
		if (longPress.state == UIGestureRecognizerState.Ended) {
			// Gesture ended
            var button = longPress.view as? UIButton
            button!.backgroundColor = UIColor(red:1.0, green:1.0,blue:1.0,alpha:1.0)

			if let someLabel = longPress.view as? UIButton {
				var alert = UIAlertController(title: "Edit button", message: "New value:", preferredStyle: UIAlertControllerStyle.Alert)
				alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
					textField.placeholder = someLabel.titleLabel?.text
					textField.secureTextEntry = false
					inputTextField = textField
				})
				alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler:{ (alertAction:UIAlertAction!) in
					// Text was changed
					someLabel.setTitle(inputTextField!.text, forState: UIControlState.Normal);
				}))
				alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler:{ (alertAction:UIAlertAction!) in
					// Nothing
				}))
				self.presentViewController(alert, animated: true, completion: nil)
    
			}

		} else if (longPress.state == UIGestureRecognizerState.Began) {
			// Gesture began
		}
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
        //textField.text = ""
    }
    
    @IBAction func buttonAutoClicked(sender: AnyObject) {
        if(autoSpeak){
            autoButton.setTitle("OFF", forState: UIControlState.Normal)
            autoSpeak = false
        } else {
            autoButton.setTitle("ON", forState: UIControlState.Normal)
            autoSpeak = true
        }
        
    }
    
    @IBAction func buttonDown(sender: AnyObject) {
        var button:UIButton = sender as! UIButton
        button.backgroundColor = UIColorFromRGB("64B069")
        
    }
    
    @IBAction func buttonCategoryDown(sender: AnyObject) {
        var button:UIButton = sender as! UIButton
        button.backgroundColor = UIColorFromRGB("37B0A8")
    }
    
    @IBAction func buttonBottomDown(sender: AnyObject) {
        var button:UIButton = sender as! UIButton
        button.backgroundColor = UIColorFromRGB("CDD14D")
    }
    
    @IBAction func buttonUpOutside(sender: AnyObject) {
        var button:UIButton = sender as! UIButton
        button.backgroundColor = UIColor(red:1.0, green:1.0,blue:1.0,alpha:1.0)
    }
    
    @IBAction func buttonClicked(sender: AnyObject) {
        var button:UIButton = sender as! UIButton
        var text = button.titleLabel!.text!
        button.backgroundColor = UIColor(red:1.0, green:1.0,blue:1.0,alpha:1.0)
        print(text)

        if(autoSpeak){
            textField.text = text
            speechHelper.say(text)
        } else {
            appendText(text)
        }
    }
    
    @IBAction func buttonCategoryClicked(sender: AnyObject) {
        var button:UIButton = sender as! UIButton
        button.backgroundColor = UIColor(red:1.0, green:1.0,blue:1.0,alpha:1.0)
        switch(sender.titleLabel!!.text!){
            case "Emotions":
                setEmotions(EMOTIONS_MAIN, bottomButtonsArray: EMOTIONS_JOINTS)
                break
            case "Food":
                setEmotions(FOOD_MAIN, bottomButtonsArray: FOOD_MAIN_JOINTS)
                break
            case "People":
                setEmotions(FRIENDS_MAIN, bottomButtonsArray: FRIENDS_JOINTS)
                break
            case "Places":
                setEmotions(PLACES_MAIN, bottomButtonsArray: PLACES_JOINTS)
                break
            case "Common":
                setEmotions(COMMON_MAIN, bottomButtonsArray: COMMON_JOINTS)
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
            dispatch_async(dispatch_get_main_queue()) {
                self.bottomButtons[index].setTitle(title as? String, forState: UIControlState.Normal)
            }
        }
    }
    
    func setMainButtons(emotions:NSArray){
        for (index, title) in enumerate(emotions){
            dispatch_async(dispatch_get_main_queue()) {
                self.buttons[index].setTitle(title as? String, forState: UIControlState.Normal)
            }
        }
    }
    
    func setCategoryButtonsTitles(categoryButtonTitles:NSArray){
        for (index, title) in enumerate(categoryButtonTitles){
            dispatch_async(dispatch_get_main_queue()) {
                self.categoryButtons[index].setTitle(title as? String, forState: UIControlState.Normal)
            }
        }
    }
    
    
    func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
        var scanner = NSScanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
}

