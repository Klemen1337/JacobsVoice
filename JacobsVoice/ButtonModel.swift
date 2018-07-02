//
//  ButtonModel.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 29/06/2018.
//  Copyright © 2018 Klemen Kastelic. All rights reserved.
//

import RealmSwift

class Button: Object {
    @objc dynamic var name = ""
    @objc dynamic var color: String? = "CCCCCC"
}
