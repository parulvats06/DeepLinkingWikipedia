//
//  LocationViewModel.swift
//  WikipediaTest
//
//  Created by Parul Vats on 13/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

import Foundation

class LocationViewModel {
    
    //MARK: - Variables
    var locations: [Location] = [] {
        didSet {
            self.reloadTableClosure?()
        }
    }
    
    var reloadTableClosure: (()->())?
    
    //MARK: - Public Methods
    // Create an array of test locations to show
    
    func fetchStaticLocations() {
        guard let path = Bundle.main.path(forResource: "Locations", ofType: "json") else {
            return
        }

        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let results = try JSONDecoder().decode(LocationList.self, from: data)
            self.locations = results.data ?? []
        } catch let err {
            print(err)
        }
    }
}

