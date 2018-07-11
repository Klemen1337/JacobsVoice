//
//  SettingsController.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 30/06/2018.
//  Copyright © 2018 Klemen Kastelic. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var sexChanger: UISegmentedControl!
    @IBOutlet weak var languagePicker: UIPickerView!
    var languages:[AVSpeechSynthesisVoice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languages = speechHelper.getLanguages()
        speedSlider.value = speechHelper.getRate()
        speedSlider.maximumValue = AVSpeechUtteranceMaximumSpeechRate
        speedSlider.minimumValue = AVSpeechUtteranceMinimumSpeechRate
        sexChanger.selectedSegmentIndex = speechHelper.getSex() == .Male ? 0 : 1
    }
    
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].name + " - " + languages[row].language
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        speechHelper.setLanguage(languages[row])
        speechHelper.say(text: "This is a test")
        print("Language:", languages[row].name)
    }
    
    
    // Speed slider changed
    @IBAction func speedSliderChange(sender: AnyObject) {
        let speedSlider:UISlider = sender as! UISlider
        speechHelper.setRate(speedSlider.value)
        speechHelper.say(text: "This is a test")
        print("Pitch:", speedSlider.value)
    }
    
    
    // Sex changer
    @IBAction func sexChanged(sender: AnyObject) {
        let sex: Sex = sexChanger.selectedSegmentIndex == 0 ? .Male : .Female
        speechHelper.setSex(sex)
        speechHelper.say(text: "This is a test")
        print("Sex:", sex)
    }
    
    
}
