//
//  UIButtonExtension.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 02/07/2018.
//  Copyright © 2018 Klemen Kastelic. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}
