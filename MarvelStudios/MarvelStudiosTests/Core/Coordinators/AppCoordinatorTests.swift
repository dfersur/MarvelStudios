//
//  AppCoordinatorTests.swift
//  MarvelStudiosTests
//
//  Created by David Manuel Fernández Suárez on 14/6/22.
//  Copyright © 2022 MynSoftware. All rights reserved.
//

@testable import MarvelStudios
import XCTest

final class AppCoordinatorTests: XCTestCase {
    
    var sut: AppCoordinator? = nil

    override func setUpWithError() throws {
        let navigationController = UINavigationController()
        sut = AppCoordinator(navigationController: navigationController)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testStart() throws {
        sut?.start()
        let initialScene = try XCTUnwrap(sut?.navigationController.topViewController as? ListViewController)
        XCTAssertNotNil(initialScene.coordinator)
    }

    func testNavigationDetail() throws {
        sut?.navigateToDetail(by: 4)
        let detailScene = try XCTUnwrap(sut?.navigationController.topViewController as? DetailViewController)
        XCTAssertEqual(detailScene.dataStore?.id, 4)
    }

}
