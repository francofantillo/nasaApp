//
//  Lululemon_DemoTests.swift
//  Lululemon DemoTests
//
//  Created by Franco Fantillo on 2022-08-01.
//

import XCTest
import Foundation
import SwiftUI
@testable import Workday

class Lululemon_DemoTests: XCTestCase {
    
//    var test_content_view_model: ContentView.ContentViewModel!
//    var test_garmentSorter: GarmentSorter!
//    var add_garment_viewmodel: AddGarmentView.AddGarmentViewModel!
//    var test_garment: Garment!
    
    var test_dataService: DataServiceProtocol!

    override func setUpWithError() throws {
        
        test_dataService = DataService()
//        test_content_view_model = ContentView.ContentViewModel(garmentSource: MockDataService())
//        test_garmentSorter = GarmentSorter()
//        add_garment_viewmodel = AddGarmentView.AddGarmentViewModel(inventoryItems: Binding<[Garment]>.constant([Garment]()),
//                                                                        isSortedAlpha: Binding<Int>.constant(0),
//                                                                        isPresented: Binding<Bool>.constant(true), garment: "Shirt")
//        let testDate = createTestDate()
//        test_garment = Garment(creationDate: testDate, name: "Shirt")
    }

    override func tearDownWithError() throws {
        
        test_dataService = nil
        
//        test_content_view_model = nil
//        test_garmentSorter = nil
//        add_garment_viewmodel = nil
//        test_garment = nil
    }
    
    func test_url_construct_from_components() throws {
        
    }
    
//    func test_add_garment_viewmodel() throws {
//        let viewmodel = add_garment_viewmodel
//        XCTAssertEqual(add_garment_viewmodel.garment, "Shirt")
//        XCTAssertEqual(add_garment_viewmodel.isSortedAlpha, 0)
//        XCTAssertEqual(add_garment_viewmodel.isPresented, true)
//        let testDate = createTestDate()
//        add_garment_viewmodel.addNewGarment(date: testDate)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//            XCTAssertEqual(viewmodel!.inventoryItems.isEmpty, true)
//            XCTAssertEqual(viewmodel!.inventoryItems[2].name, "Shirt")
//            XCTAssertEqual(viewmodel!.inventoryItems[2].creationDate, testDate)
//        })
//    }
//
//    func test_garment_model(){
//        let testDate = createTestDate()
//        XCTAssertEqual(test_garment.name, "Shirt")
//        XCTAssertEqual(test_garment.creationDate, testDate)
//        XCTAssertNotNil(test_garment.id)
//    }
//
//    func test_content_view() throws {
//
//        XCTAssertEqual(test_content_view_model.garments.count, 3)
//        print(test_content_view_model.garments[2].name)
//        XCTAssert(test_content_view_model.garments[2].name == "Shirt")
//        XCTAssert(Calendar.current.component(.year, from: test_content_view_model.garments[2].creationDate) == 1980)
//
//
//        print(test_content_view_model.garments[1].name)
//        XCTAssert(test_content_view_model.garments[1].name == "Pants")
//        XCTAssert(Calendar.current.component(.year, from: test_content_view_model.garments[1].creationDate) == 2000)
//
//        print(test_content_view_model.garments[0].name)
//        XCTAssert(test_content_view_model.garments[0].name == "Apple")
//        XCTAssert(Calendar.current.component(.year, from: test_content_view_model.garments[0].creationDate) == 1980)
//    }
//
//    func test_sorter_alpha() throws {
//
//        let garments = test_garmentSorter.sortGarments(isSortedAlpha: true, garments: test_content_view_model.garments)
//        XCTAssert(garments[0].name == "Apple")
//        XCTAssert(garments[1].name == "Pants")
//        XCTAssert(garments[2].name == "Shirt")
//    }
//
//    func test_sorter_date() throws {
//        let garments = test_garmentSorter.sortGarments(isSortedAlpha: false, garments: test_content_view_model.garments)
//        XCTAssert(Calendar.current.component(.year, from: garments[0].creationDate) == 1980)
//        XCTAssert(Calendar.current.component(.year, from: garments[1].creationDate) == 1980)
//        XCTAssert(Calendar.current.component(.year, from: garments[2].creationDate) == 2000)
//    }
//
//    func createTestDate() -> Date {
//        // Specify date components
//        var dateComponents = DateComponents()
//        dateComponents.year = 1980
//        dateComponents.month = 7
//        dateComponents.day = 11
//        dateComponents.timeZone = TimeZone(abbreviation: "PST") // Japan Standard Time
//        dateComponents.hour = 8
//        dateComponents.minute = 34
//
//        // Create date from components
//        let userCalendar = Calendar(identifier: .gregorian) // since the components above (like year 1980) are for Gregorian
//        let someDateTime = userCalendar.date(from: dateComponents)!
//        return someDateTime
//    }
}
