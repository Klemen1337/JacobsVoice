//
//  DatabaseHelper.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 21/02/16.
//  Copyright © 2016 Klemen Kastelic. All rights reserved.
//

import UIKit
import Foundation
import CoreData

public class DatabaseHelper {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func setup(){
        if(getCategories().count == 0){
            addCategory("Emotions")
            for text in EMOTIONS_MAIN{
                addButtonToCategory(text, category:"Emotions")
            }
            
            
            addCategory("Food")
            for text in FOOD_MAIN{
                addButtonToCategory(text, category:"Food")
            }
            
            
            addCategory("People")
            for text in PEOPLE_MAIN{
                addButtonToCategory(text, category:"People")
            }
            
            
            addCategory("Places")
            for text in PLACES_MAIN{
                addButtonToCategory(text, category:"Places")
            }
            
            
            addCategory("Common")
            for text in COMMON_MAIN{
                addButtonToCategory(text, category:"Common")
            }
        }
    }
    
    
    func getCategories() -> [Any] {
        return []
    }
    
    
    func addCategory(_ name:String){


    }
    
    
    
    func getButtonsFromCategory(_ category:String) -> [Any] {
        return []
    }
    
    
    func addButtonToCategory(_ name:String, category:String){

        
    }

}
