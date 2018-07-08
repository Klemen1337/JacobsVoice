//
//  CategoryCell.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 30/06/2018.
//  Copyright © 2018 Klemen Kastelic. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var label: UILabel!
    public var category: Category?
    
    public func set(_ category: Category){
        self.category = category
        self.mainButton.setTitle(self.category?.name, for: .normal)
        self.label.text = self.category?.name
    }
}
