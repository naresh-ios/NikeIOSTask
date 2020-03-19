//
//  ListViewTestCases.swift
//  NikeIOSAssessmentTests
//
//  Created by Naresh Nadhendla on 3/19/20.
//  Copyright © 2020 Naresh Nadhendla. All rights reserved.
//

import XCTest
@testable import NikeIOSAssessment

class ListViewTestCases: XCTestCase {
    var listViewController: ListViewController!
    
    override func setUp() {
        super.setUp()
        listViewController = ListViewController()
        listViewController.loadView()
    }
    
    override func tearDown() {
        listViewController = nil
        super.tearDown()
    }
    
    func testNavigationTitle() {
        let guess = listViewController.navigationItem.title
        XCTAssertEqual(guess, "List View")
    }
    
    func testTableViewSections() {
        let resultsTableView = listViewController.resultsTableView.numberOfSections
        XCTAssertEqual(resultsTableView, 1)
    }

    func testServiceURL() {
        let serviceURL = listViewController.serviceURL
        XCTAssertEqual(serviceURL, "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json")
    }

    func testCellID() {
        let cellID = listViewController.cellID
        XCTAssertEqual(cellID, "cell")
    }
}
