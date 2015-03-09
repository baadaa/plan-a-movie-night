//
//  MainTabBarController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/8/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate, UITabBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in self.tabBar.items as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)).imageWithRenderingMode(.AlwaysOriginal)
                
                // this changes tintColor of each Tab Bar Item for normal state.
            }
        }
    }
}

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext() as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
        // This is borrowed from http://stackoverflow.com/questions/25052729/default-tab-bar-item-colors-using-swift-xcode-6 for Tab Bar Item icon color change
}

