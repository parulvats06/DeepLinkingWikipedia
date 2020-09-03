//
//  LocationModel.swift
//  WikipediaTest
//
//  Created by Parul Vats on 13/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

import Foundation

struct Location: Decodable {
    var title: String!
    var latitude: String!
    var longitude: String!
}

extension Location: Hashable {
    
}

struct LocationList: Decodable {
    var data: [Location]?
}
