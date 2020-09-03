//
//  UIView+Addition.swift
//  WikipediaTest
//
//  Created by Parul Vats on 13/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

import UIKit
import QuartzCore

// MARK: - Properties
public extension UIView {
    
    // Add round corners to the view
    func roundCorners(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    // Add border with color and round corner to the view
    func makeLayer( color: UIColor, boarderWidth: CGFloat, round:CGFloat) -> Void {
        self.layer.borderWidth = boarderWidth
        self.layer.cornerRadius = round
        self.layer.masksToBounds =  true
        self.layer.borderColor = color.cgColor
    }
    
    // Show view with animation
    func fadeIn() {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha = 0
        UIView.animate(withDuration: 0.35) {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    // Hide view with animation
    func fadeOut() {
        UIView.animate(withDuration: 0.2, animations: {
        }) { (finished : Bool) in
            if finished {
                self.removeFromSuperview()
            }
        }
    }
}
