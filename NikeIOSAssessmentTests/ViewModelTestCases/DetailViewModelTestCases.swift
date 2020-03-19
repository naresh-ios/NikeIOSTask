//
//  DetailViewModelTestCases.swift
//  NikeIOSAssessmentTests
//
//  Created by Naresh Nadhendla on 3/19/20.
//  Copyright © 2020 Naresh Nadhendla. All rights reserved.
//

import XCTest
@testable import NikeIOSAssessment

class DetailViewModelTestCases: XCTestCase {
    var viewModel: DetailViewControllerViewModel!

    override func setUp() {
        let genres = [Genre(genreId: "14", name: "Pop", url: "https://itunes.apple.com/us/genre/id14")]
        let resultObject = Result(artistName: "OneRepublic", id: "1502298673", releaseDate: "2020-05-08", name: "Human (Deluxe)", kind: "album", copyright: "℗ 2020 Mosley Music/Interscope Records", artistId: "260414340", artistUrl: "https://music.apple.com/us/artist/onerepublic/260414340?app=music", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music113/v4/92/cb/79/92cb7922-3159-e829-739e-d1221749bf8b/19UMGIM85967.rgb.jpg/200x200bb.png", url: "https://itunes.apple.com/us/genre/id34", genres: genres)
        viewModel = DetailViewControllerViewModel(productAlbum: resultObject)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testArtistId() {
        let album = viewModel.productAlbum
        XCTAssertEqual(album?.artistId, "260414340")
    }

    func testArtistName() {
        let album = viewModel.productAlbum
        XCTAssertEqual(album?.artistName, "OneRepublic")
    }

    func testArtistUrl() {
        let album = viewModel.productAlbum
        XCTAssertEqual(album?.artistUrl, "https://music.apple.com/us/artist/onerepublic/260414340?app=music")
    }

    func testReleaseDate() {
        let album = viewModel.productAlbum
        XCTAssertEqual(album?.releaseDate, "2020-05-08")
    }

    func testName() {
        let album = viewModel.productAlbum
        XCTAssertEqual(album?.name, "Human (Deluxe)")
    }

    func testKind() {
        let album = viewModel.productAlbum
        XCTAssertEqual(album?.kind, "album")
    }

    func testGenreId() {
        let album = viewModel.productAlbum
        XCTAssertEqual(album?.genres.first?.genreId, "14")
    }

    func testGenreUrl() {
        let album = viewModel.productAlbum
        XCTAssertEqual(album?.genres.first?.url, "https://itunes.apple.com/us/genre/id14")
    }
}
