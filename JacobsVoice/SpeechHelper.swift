//
//  SpeechHelper.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 17/05/15.
//  Copyright (c) 2015 Klemen Kastelic. All rights reserved.
//

import Foundation
import AVFoundation

public class SpeechHelper {
    var language:String = "en-US"
    var rate:Float = 0.2;
    var mySpeechSynthesizer:AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    func say(text:String){
        if(mySpeechSynthesizer.speaking){
            mySpeechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        }
        var mySpeechUtterance:AVSpeechUtterance = AVSpeechUtterance(string:text)
        mySpeechUtterance.rate = rate;
        mySpeechSynthesizer.speakUtterance(mySpeechUtterance)
    }
}