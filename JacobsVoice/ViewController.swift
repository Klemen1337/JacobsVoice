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
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var textField: UITextField!
    var speechHelper = SpeechHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(EMOTIONS)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SpeakButtonClicked(sender: AnyObject) {
        speechHelper.say(textField.text)
        textField.text = ""
    }
    
    @IBAction func buttonClicked(sender: AnyObject) {
        var button:UIButton = sender as! UIButton
        appendText(sender.titleLabel!!.text!)
    }
    
    
    func appendText(text:String) {
        textField.text = textField.text + text + " "
    }
}

