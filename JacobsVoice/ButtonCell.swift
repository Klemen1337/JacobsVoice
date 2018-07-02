//
//  ButtonCell.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 29/06/2018.
//  Copyright © 2018 Klemen Kastelic. All rights reserved.
//

import UIKit


class ButtonCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainButton: UIButton!
    public var button: Button?
    
    
    
    public func set(_ button: Button){
        self.button = button
        self.mainButton.setTitle(self.button?.name, for: .normal)
        //self.mainButton.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        
        let color = UIColor(hexString: self.button?.color ?? "cccccc")
        self.mainButton.borderColor = color
        self.mainButton.setBackgroundColor(color, forState: .highlighted)
    }
    
    
    func longPressed(longPress: UIGestureRecognizer) {
        var inputTextField: UITextField?
        if (longPress.state == UIGestureRecognizerState.ended) {
            // Gesture ended
            let button = longPress.view as? UIButton
            button!.backgroundColor = UIColor(red:1.0, green:1.0,blue:1.0,alpha:1.0)
            
            if let someLabel = longPress.view as? UIButton {
                let alert = UIAlertController(title: "Edit button", message: "New value:", preferredStyle: UIAlertControllerStyle.alert)
                alert.addTextField(configurationHandler: {(textField: UITextField) in
                    textField.placeholder = someLabel.titleLabel?.text
                    //textField.secureTextEntry = false
                    inputTextField = textField
                })
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (alertAction:UIAlertAction) in
                    // Text was changed
                    someLabel.setTitle(inputTextField!.text, for: UIControlState.normal);
                    let text = inputTextField!.text ?? ""
                    print(text)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:{ (alertAction:UIAlertAction) in
                    // Nothing
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }
            
        } else if (longPress.state == UIGestureRecognizerState.began) {
            // Gesture began
        }
    }
}
