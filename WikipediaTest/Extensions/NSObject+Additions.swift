//
//  NSObject+Additions.swift
//  WikipediaTest
//
//  Created by Parul Vats on 14/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
}
