//
//  DatabaseHelper.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 21/02/16.
//  Copyright © 2016 Klemen Kastelic. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

public class DatabaseHelper {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func setup(){
        for (categoryName, categoryButtons) in PRESETS["en"]! {
            let cat = Category(value: [
                "name": categoryName,
                "buttons": []
            ])
            
            for name in categoryButtons {
                cat.buttons.append(Button(value: ["name": name]));
            }
            
            
            self.addCategory(cat)
            //self.categories.append(cat);
        }
        
        //self.setUpCategoryButtons(self.categories[0].name)
    }
    
    
    func getCategories() -> [Category] {
        let realm = try! Realm()
        return Array(realm.objects(Category.self))
    }
    
    
    func addCategory(_ category: Category){
        let realm = try! Realm()
        try! realm.write() {
            realm.add(category)
        }
    }
    
    
    func updateCategoryName(_ category: Category, name: String){
        
    }
    
    
    func addButtonToCategory(_ button:Button, category:Category){
        let realm = try! Realm()
        try! realm.write() {
            
        }
    }

}
