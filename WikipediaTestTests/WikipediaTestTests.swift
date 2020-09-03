//
//  WikipediaTestTests.swift
//  WikipediaTestTests
//
//  Created by Parul Vats on 10/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

import XCTest
@testable import WikipediaTest

class WikipediaTestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testModelParsing() {
        let viewModel: LocationViewModel = LocationViewModel()
        viewModel.fetchStaticLocations()
        XCTAssert(viewModel.locations.count == 5, "Location count is incorrect")
    }
    
    func testLocationData() {
        let viewModel: LocationViewModel = LocationViewModel()
        viewModel.fetchStaticLocations()
        let location = viewModel.locations[1]
        XCTAssert(location.title == "Stationsplein, Amsterdam", "Title is incorrect")
        XCTAssert(location.latitude == "52.3785", "latitude is incorrect")
        XCTAssert(location.longitude == "4.8990", "longitude is incorrect")
    }
    
    func testWhenItIsAValidLocation() {
        let isValid = Utilities.isValidLocation(latitude:-28.5784, longitude: 121.20)
        
        XCTAssert(isValid == true, "Location is valid but gives invalid")
    }
    
    func testWhenItIsAInvalidLocation() {
        let isValid = Utilities.isValidLocation(latitude:-128.5784, longitude: 121.20)
        
        XCTAssert(isValid == false, "Location is invalid but gives valid")
    }

}
