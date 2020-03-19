//
//  DetailViewTestCases.swift
//  NikeIOSAssessmentTests
//
//  Created by Naresh Nadhendla on 3/19/20.
//  Copyright © 2020 Naresh Nadhendla. All rights reserved.
//

import XCTest
@testable import NikeIOSAssessment

class DetailViewTestCases: XCTestCase {
    var viewModel: DetailViewControllerViewModel!
    var detailViewController: DetailViewController!

    override func setUp() {
        let genres = [Genre(genreId: "14", name: "Pop", url: "https://itunes.apple.com/us/genre/id14")]
        let resultObject = Result(artistName: "OneRepublic", id: "1502298673", releaseDate: "2020-05-08", name: "Human (Deluxe)", kind: "album", copyright: "℗ 2020 Mosley Music/Interscope Records", artistId: "260414340", artistUrl: "https://music.apple.com/us/artist/onerepublic/260414340?app=music", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music113/v4/92/cb/79/92cb7922-3159-e829-739e-d1221749bf8b/19UMGIM85967.rgb.jpg/200x200bb.png", url: "https://itunes.apple.com/us/genre/id34", genres: genres)
        viewModel = DetailViewControllerViewModel(productAlbum: resultObject)
        detailViewController = DetailViewController()
        detailViewController.viewModel = viewModel
        detailViewController.loadView()
    }

    override func tearDown() {
        detailViewController = nil
        super.tearDown()
    }

    func testNavigationTitle() {
        let guess = detailViewController.navigationItem.title
        XCTAssertEqual(guess, "Detail View")
    }
    
    func testStackViewSetup() {
        let space = detailViewController.stackView.spacing
        XCTAssertEqual(space, 10)
    }
    
    func testStackViewSubViews() {
        let subViews = detailViewController.stackView.arrangedSubviews
        XCTAssertEqual(subViews, [])
    }
    
    func testGetLabelFunction() {
        let label = detailViewController.getLabel(with: "Human (Deluxe)")
        XCTAssertEqual(label.text, "Human (Deluxe)")
    }

    func testLabelArtistName() {
        let productAlbum = detailViewController.viewModel.productAlbum
        XCTAssertEqual(productAlbum?.artistName, "OneRepublic")
    }
}
