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
    var male:Bool = true
    var rate:Float = 0.5
    var mySpeechSynthesizer:AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    
    func say(text:String){
        if(mySpeechSynthesizer.isSpeaking){
            mySpeechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
        
        let mySpeechUtterance:AVSpeechUtterance = AVSpeechUtterance(string:text)
        
        
        if(male){
            mySpeechUtterance.voice = AVSpeechSynthesisVoice(identifier: AVSpeechSynthesisVoiceIdentifierAlex)
        } else {
            mySpeechUtterance.voice = AVSpeechSynthesisVoice(language: language)
        }
        
        mySpeechUtterance.rate = rate;
        
        mySpeechSynthesizer.speak(mySpeechUtterance)
    }
    
    
    func setSpeed(speed:Float){
        rate = speed;
    }
    
    func getSpeed() -> Float{
        return rate;
    }
    
    
    func setSex(sex:String){
        if(sex == "Male"){
            male = true
        } else {
            male = false
        }
    }
    
    func getSex() -> String{
        if(male) {
           return "Male"
        } else {
           return "Female";
        }
    }
}
