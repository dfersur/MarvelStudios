//
//  ListViewControllerTests.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 13/6/22.
//  Copyright (c) 2022 MynSoftware. All rights reserved.
//

@testable import MarvelStudios
import XCTest

class ListViewControllerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: ListViewController!
    var window: UIWindow!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupListViewController()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupListViewController() {
        sut = ListViewController()
    }
  
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
  
    // MARK: Spies
  
    class ListPresenterLogicSpy: ListPresenterLogic {
        
        var setupViewCalled: Bool = false
        var filterListCalled: Bool = false
        var didSelectRowAtCalled: Bool = false

        func setupView() {
            setupViewCalled = true
        }
        
        func filterList(text: String?) {
            filterListCalled = true
        }
        
        func didSelectRowAt(index: Int) {
            didSelectRowAtCalled = true
        }
    }
    
    class AppCoordinatorSpy: AppCoordinator {
        var navigateToDetailCalled: Bool = false
        
        var idSelected: Int?
        
        override func navigateToDetail(by id: Int) {
            navigateToDetailCalled = true
            idSelected = id
        }
    }
  
  // MARK: Tests
  
    func testShouldSetupViewWhenViewIsLoaded() {
        // Given
        let spy = ListPresenterLogicSpy()
        sut.presenter = spy

        // When
        sut.setupView()

        // Then
        XCTAssertTrue(spy.setupViewCalled)
        XCTAssertEqual(sut.title!, "Lista")
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.navigationItem.searchController)
    }
    
    func testDatasourceNumberOfRows() {
        // Given
        sut.characterList = ListMocks.getList()
        
        // When
        let result = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(result, 2)
    }
    
    func testDatasourceCellForRowAt() throws {
        // Given
        sut.characterList = ListMocks.getList()
        
        // When
        let result = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        let listTableViewCell = try XCTUnwrap(result as? ListTableViewCell)
        XCTAssertEqual(listTableViewCell.title.text, sut.characterList.first?.name)
    }
    
    func testDidSelectedRow() {
        // Given
        let spy = ListPresenterLogicSpy()
        sut.presenter = spy
        sut.characterList = ListMocks.getList()
        
        // When
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        
        // Then
        XCTAssertTrue(spy.didSelectRowAtCalled)
    }
    
    func testNavigateToDetail() throws {
        // Given
        
        let navigationController = UINavigationController(rootViewController: sut)
        let coordinatorSpy = AppCoordinatorSpy(navigationController: navigationController)
        sut.coordinator = coordinatorSpy
        
        // When
        sut.navigateToDetail(id: 1)
        
        // Then
        XCTAssertTrue(coordinatorSpy.navigateToDetailCalled)
    }
}
