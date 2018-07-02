//
//  CategoryModel.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 02/07/2018.
//  Copyright © 2018 Klemen Kastelic. All rights reserved.
//

import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let buttons = List<Button>()
}
