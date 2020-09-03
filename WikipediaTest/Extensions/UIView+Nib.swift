//
//  UIView+Nib.swift
//  WikipediaTest
//
//  Created by Parul Vats on 14/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

import UIKit
extension UIView {
    // 1. Call this method from your init functions
    /// Helper method to init and setup the view from the Nib.
    func xibSetup() {
        let view = loadFromNib()
        view.frame = bounds
        addSubview(view)
    }
    
    //  2. Loads the view from the nib in the bundle
    /// Method to init the view from a Nib.
    ///
    /// - Returns: Optional UIView initialized from the Nib of the same class name.
    func loadFromNib<T: UIView>() -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
            guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName)")
        }
        return view
    }
}

