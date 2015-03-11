//
//  Checkbox.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class Checkbox: UIButton {

    // custom checkbox class: borrowed codes from https://www.youtube.com/watch?v=ajlkFFPxW_c
    
    let checkedImage = UIImage(named: "checked")
    let uncheckedImage = UIImage(named: "unchecked")
    
    var isChecked:Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, forState: .Normal)
            } else {
                self.setImage(uncheckedImage, forState: .Normal)
            }
        }   // Anytime the boolean value changes this code block runs
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonTapped:", forControlEvents:UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    func buttonTapped(sender: UIButton) {
        if (sender == self) {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
}
