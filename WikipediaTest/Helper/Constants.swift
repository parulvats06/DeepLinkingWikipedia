//
//  Constants.swift
//  WikipediaTest
//
//  Created by Parul Vats on 13/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

import UIKit

struct Constants {
    struct Devices {
        @available(iOS 13.0, *)
        static let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    
    struct StringConstants {
        static let wikiDeepLink = "wikipedia://places/location?"
    }
}
