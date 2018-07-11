//
//  SpeechHelper.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 17/05/15.
//  Copyright (c) 2015 Klemen Kastelic. All rights reserved.
//

import Foundation
import AVFoundation

enum Sex: String {
    case Male
    case Female
}

struct Settings {
    static let Rate = "settings-rate"
    static let Sex = "settings-sex"
    static let Language = "settings-language"
}


public class SpeechHelper {
    var language: AVSpeechSynthesisVoice = AVSpeechSynthesisVoice.speechVoices()[0]
    var sex: Sex = .Male
    var rate: Float = AVSpeechUtteranceDefaultSpeechRate
    var pitch: Float = 1.0
    var speechSynthesizer:AVSpeechSynthesizer = AVSpeechSynthesizer()
    

    init() {
        print("Loading settings...")
        loadSettings()
    }
    
    
    func say(text:String){
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                // Stop before speeking
                if(self.speechSynthesizer.isSpeaking){
                    self.speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
                }
                
                let speechUtterance = AVSpeechUtterance(string:text)
                speechUtterance.rate = self.rate
                speechUtterance.voice = self.language
                speechUtterance.pitchMultiplier = self.pitch
                self.speechSynthesizer.speak(speechUtterance)
            }
        }
    }
    
    
    func setRate(_ newRate:Float){
        rate = newRate
        saveSettings()
    }
    
    func getRate() -> Float{
        return rate
    }
    
    
    func setPitch(_ newPitch:Float){
        pitch = newPitch
        saveSettings()
    }
    
    func getPitch() -> Float{
        return pitch
    }
    
    
    func setSex(_ newSex: Sex){
        sex = newSex
        saveSettings()
    }
    
    func getSex() -> Sex{
        return sex
    }
    
    
    func setLanguage(_ newlanguage: AVSpeechSynthesisVoice){
        language = newlanguage
        saveSettings()
    }
    
    func getLanguages() -> [AVSpeechSynthesisVoice] {
        return AVSpeechSynthesisVoice.speechVoices()
    }
    
    func loadSettings() {
        let defaults = UserDefaults.standard
        rate = defaults.float(forKey: Settings.Rate)
        sex = defaults.integer(forKey: Settings.Sex) == 1 ? .Male : .Female
        language = AVSpeechSynthesisVoice.init(identifier: defaults.string(forKey: Settings.Language)!) ?? AVSpeechSynthesisVoice.speechVoices()[0]
    }
    
    func saveSettings() {
        let defaults = UserDefaults.standard
        defaults.set(rate, forKey: Settings.Rate)
        defaults.set(sex == .Male ? 1:0, forKey: Settings.Sex)
        defaults.set(language.identifier, forKey: Settings.Language)
    }
}
