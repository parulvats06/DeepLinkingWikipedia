//
//  Utilities.swift
//  WikipediaTest
//
//  Created by Parul Vats on 14/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

open class Utilities {
    public static func isValidLocation(latitude: Double, longitude: Double) -> Bool {
        guard (longitude > -180 && longitude < 180), (latitude > -90 && latitude < 90) else {
            return false
        }
        return true
    }
}
