//
//  SettingsController.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 30/06/2018.
//  Copyright © 2018 Klemen Kastelic. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var sexChanger: UISegmentedControl!
    @IBOutlet weak var languagePicker: UIPickerView!
    
    var speechHelper = SpeechHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagePicker.delegate = self
        languagePicker.dataSource = self
        speedSlider.value = speechHelper.getSpeed()
        sexChanger.selectedSegmentIndex = speechHelper.getSex() == "Male" ? 0 : 1
    }
    
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LANGUAGES.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return LANGUAGES[row]
    }
    
    // Close settings btn
    @IBAction func settingsBtnClose(sender: AnyObject) {
        settingsView.isHidden = true;
    }
    
    // Speed slider changed
    @IBAction func speedSliderChange(sender: AnyObject) {
        let speedSlider:UISlider = sender as! UISlider
        speechHelper.setSpeed(speed: speedSlider.value);
    }
    
    
    // Sex changer
    @IBAction func sexChanged(sender: AnyObject) {
        speechHelper.setSex(sex: sexChanger.titleForSegment(at: sexChanger.selectedSegmentIndex)!)
    }
}
