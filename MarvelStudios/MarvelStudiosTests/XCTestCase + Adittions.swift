//
//  XCTests + Adittions.swift
//  MarvelStudiosTests
//
//  Created by David Manuel Fernández Suárez on 13/6/22.
//  Copyright © 2022 MynSoftware. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func waitUI(withDelay: Double = 0) {
        let expectation = expectation(description: "UI Waiting")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: withDelay + 100, handler: nil)
    }
    
}
