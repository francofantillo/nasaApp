//
//  ViewModelTests.swift
//  NasaAppTests
//
//  Created by Franco Fantillo
//

import XCTest
@testable import NasaApp

final class ViewModelTests: XCTestCase {
    
    var httpClientSuccessOneItemWithNextLink: HttpClient!
    var nasaListVMOneItemWithNextLink: NasaList.NasaListViewModel!
    
    var httpClientSuccessOneItemNoNext: HttpClient!
    var nasaListVMOneItemNoNext: NasaList.NasaListViewModel!
    
    var httpClientSuccessOneItemNoCollectionLink: HttpClient!
    var nasaListVMOneItemNoCollectionLink: NasaList.NasaListViewModel!

    override func setUpWithError() throws {
        super.setUp()
        
        let nasaData = NasaData(date_created: "November", description: "This is nasa data.", title: "Nasa")
        let nasaLink = NasaLinks(href: "www.href.com", render: "www.render.com", rel: "www.rel.com")
        let nasaItem = NasaItem(data: [nasaData], href: "nasa item href", links: [nasaLink])
        let nextCollectionLink = CollectonLinks(href: "http://www.nextlink.com", prompt: "", rel: "next")
        let nasaCollectionWithNext = NasaCollection(href: "www.nasalink.com", items: [nasaItem], links: [nextCollectionLink])
        
        let nextData = try! JSONEncoder().encode(nasaCollectionWithNext)
        let sessionSuccessWithNext = MockURLSession(testCase: .success, nextData: nextData)
        
        httpClientSuccessOneItemWithNextLink = HttpClient(session: sessionSuccessWithNext)
        nasaListVMOneItemWithNextLink = NasaList.NasaListViewModel(service: DataService(client: httpClientSuccessOneItemWithNextLink))
        
        let noNextCollectionLink = CollectonLinks(href: "http://www.nextlink.com", prompt: "", rel: "prev")
        let nasaCollectionNoNext = NasaCollection(href: "www.nasalink.com", items: [nasaItem], links: [noNextCollectionLink])
        
        let noNextData = try! JSONEncoder().encode(nasaCollectionNoNext)
        let sessionSuccessNoNext = MockURLSession(testCase: .success, nextData: noNextData)
        
        httpClientSuccessOneItemNoNext = HttpClient(session: sessionSuccessNoNext)
        nasaListVMOneItemNoNext = NasaList.NasaListViewModel(service: DataService(client: httpClientSuccessOneItemNoNext))
        nasaListVMOneItemNoNext.nextPageLink = "https://www.nextlink.com"
        
        let nasaCollectionNoLinks = NasaCollection(href: "www.nasalink.com", items: [nasaItem], links: [])
        let noLinksData = try! JSONEncoder().encode(nasaCollectionNoLinks)
        let sesssionSuccessNoLinks = MockURLSession(testCase: .success, nextData: noLinksData)
        
        httpClientSuccessOneItemNoCollectionLink = HttpClient(session: sesssionSuccessNoLinks)
        nasaListVMOneItemNoCollectionLink = NasaList.NasaListViewModel(service: DataService(client: httpClientSuccessOneItemNoCollectionLink))
        nasaListVMOneItemNoCollectionLink.nextPageLink = "https://www.nextlink.com"
    }

    override func tearDownWithError() throws {
        
        httpClientSuccessOneItemWithNextLink = nil
        nasaListVMOneItemWithNextLink = nil
        httpClientSuccessOneItemNoNext = nil
        nasaListVMOneItemNoNext = nil
        httpClientSuccessOneItemNoCollectionLink = nil
        nasaListVMOneItemNoCollectionLink = nil
    }

    func test_get_nasaItems_with_next() async throws {
        
        try! await nasaListVMOneItemWithNextLink.getNasaItems(searchString: "p")
        
        sleep(1)
        print(nasaListVMOneItemWithNextLink.items.count)
        XCTAssert(nasaListVMOneItemWithNextLink.items.count == 1)
        XCTAssert(nasaListVMOneItemWithNextLink.nextPageLink == "https://www.nextlink.com")
    }
    
    func test_get_nasaItems_no_next() async throws {
        
        try! await nasaListVMOneItemNoNext.getNasaItems(searchString: "p")
        
        sleep(1)
        print(nasaListVMOneItemNoNext.items.count)
        XCTAssert(nasaListVMOneItemNoNext.items.count == 1)
        XCTAssert(nasaListVMOneItemNoNext.nextPageLink == "")
    }
    
    func test_get_nasaItems_no_links() async throws {
        
        try! await nasaListVMOneItemNoCollectionLink.getNasaItems(searchString: "p")
        
        sleep(1)
        print(nasaListVMOneItemNoCollectionLink.items.count)
        XCTAssert(nasaListVMOneItemNoCollectionLink.items.count == 1)
        XCTAssert(nasaListVMOneItemNoCollectionLink.nextPageLink == "")
    }
    
    func test_get_next_page_data() async throws {
        
        try! await nasaListVMOneItemWithNextLink.getNasaItems(searchString: "p")
        
        sleep(1)
        print(nasaListVMOneItemWithNextLink.items.count)
        XCTAssert(nasaListVMOneItemWithNextLink.items.count == 1)
        XCTAssert(nasaListVMOneItemWithNextLink.nextPageLink == "https://www.nextlink.com")
        
        try! await nasaListVMOneItemWithNextLink.getNextPage()
        
        ///sleep(1)
        print(nasaListVMOneItemWithNextLink.items.count)
        XCTAssert(nasaListVMOneItemWithNextLink.items.count == 2)
    }
    
    func testCancelTask() async throws {
        // Given
        let searchString = "moon"

        // When
        nasaListVMOneItemWithNextLink.nasaTask = Task {
            do {
                sleep(2)
            } catch {
                XCTFail("Task should not fail")
            }
        }
        nasaListVMOneItemWithNextLink.cancelTask()

        // Then
        XCTAssertNil(nasaListVMOneItemWithNextLink.nasaTask)
    }
}
