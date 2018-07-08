//
//  ButtonCell.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 29/06/2018.
//  Copyright © 2018 Klemen Kastelic. All rights reserved.
//

import UIKit


class ButtonCell: UICollectionViewCell {
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var label: UILabel!
    public var button: Button?
    
    public func set(_ button: Button){
        self.button = button
        self.label.text = self.button?.name
        self.mainButton.setTitle(self.button?.name, for: .normal)
        
        let color = UIColor(hexString: self.button?.color ?? "cccccc")
        self.mainButton.borderColor = color
    }
}
