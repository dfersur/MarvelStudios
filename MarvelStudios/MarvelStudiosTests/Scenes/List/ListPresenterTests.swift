//
//  ListPresenterTests.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 13/6/22.
//  Copyright (c) 2022 MynSoftware. All rights reserved.
//

@testable import MarvelStudios
import XCTest

class ListPresenterTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: ListPresenter!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupListPresenter()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupListPresenter() {
        sut = ListPresenter()
    }
  
    // MARK: Spies
  
    class ListDisplayLogicSpy: ListDisplayLogic, ListRouterLogic {
        
        var setupViewCalled: Bool = false
        var updateUICalled: Bool = false
        var showAlertCalled: Bool = false
        var showLoadingCalled: Bool = false
        var hideLoadingCalled: Bool = false
        
        var idNavigation: Int?
        
        func setupView() {
            setupViewCalled = true
        }
        
        func updateUI(list: [MarvelStudios.List.CharacterViewModel]) {
            updateUICalled = true
        }
        
        func showAlert(title: String, message: String) {
            showAlertCalled = true
        }
        
        func showLoading() {
            showLoadingCalled = true
        }
        
        func hideLoading() {
            hideLoadingCalled = true
        }
        
        // MARK: Router Spy Logic
        
        var navigateToDetailCalled = false
        
        func navigateToDetail(id: Int) {
            idNavigation = id
            navigateToDetailCalled = true
        }
    }
  
    // MARK: Tests
  
    func testSetupShouldSuccess() {
        
        // Given
        let spy = ListDisplayLogicSpy()
        sut.view = spy
        
        sut.repository = CharacterRepositorySpy().prepareForSuccess()
        
        // When
        sut.setupView()
        
        waitUI()
        
        // Then
        XCTAssertTrue(spy.setupViewCalled)
        XCTAssertTrue(spy.showLoadingCalled)
        XCTAssertTrue(spy.hideLoadingCalled)
        XCTAssertTrue(spy.updateUICalled)
    }
    
    func testSetupShouldFailure() {
        
        // Given
        let spy = ListDisplayLogicSpy()
        sut.view = spy
        
        sut.repository = CharacterRepositorySpy().prepareForFailure()
        
        // When
        sut.setupView()
        
        waitUI()
        
        // Then
        XCTAssertTrue(spy.setupViewCalled)
        XCTAssertTrue(spy.showLoadingCalled)
        XCTAssertTrue(spy.hideLoadingCalled)
        XCTAssertFalse(spy.updateUICalled)
        XCTAssertTrue(spy.showAlertCalled)
    }
    
    func testFilterListShouldShowFullListWhenTextIsNil() {
        // Given
        let spy = ListDisplayLogicSpy()
        sut.view = spy
        
        sut.list = ListMocks.getList()
        
        sut.filterList(text: nil)
        
        XCTAssertTrue(spy.updateUICalled)
        XCTAssertEqual(sut.filteredList.count, 2)
    }
    
    func testFilterListShouldShowFullListWhenTextIsEmpty() {
        // Given
        let spy = ListDisplayLogicSpy()
        sut.view = spy
        
        sut.list = ListMocks.getList()
        
        sut.filterList(text: "")
        
        XCTAssertTrue(spy.updateUICalled)
        XCTAssertEqual(sut.filteredList.count, 2)
    }
    
    func testFilterListShouldShowFilteredList() {
        // Given
        let spy = ListDisplayLogicSpy()
        sut.view = spy
        
        sut.list = ListMocks.getList()
        
        sut.filterList(text: "prueba1")
        
        XCTAssertTrue(spy.updateUICalled)
        XCTAssertEqual(sut.filteredList.count, 1)
    }
    
    func testDidSelectRowAt() {
        // Given
        let spy = ListDisplayLogicSpy()
        sut.view = spy
        
        sut.filteredList = ListMocks.getList()
        
        // When
        sut.didSelectRowAt(index: 1)
        
        // Then
        XCTAssertTrue(spy.navigateToDetailCalled)
        XCTAssertEqual(spy.idNavigation, 1)
    }
    
}
