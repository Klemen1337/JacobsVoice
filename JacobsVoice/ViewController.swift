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
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var button_one: UIButton!
    @IBOutlet weak var button_two: UIButton!
    @IBOutlet weak var button_three: UIButton!
    @IBOutlet weak var button_bottom_one: UIButton!
    @IBOutlet weak var button_button_one: UIButton!
    
    var speechHelper = SpeechHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SpeakButtonClicked(sender: AnyObject) {
        speechHelper.say(TextField.text)
        TextField.text = ""
    }
    
    @IBAction func buttonClicked(sender: AnyObject) {
        var button:UIButton = sender as! UIButton
        appendText(sender.titleLabel!!.text!)
    }
    
    
    func appendText(text:String) {
        TextField.text = TextField.text + text + " "
    }
}

