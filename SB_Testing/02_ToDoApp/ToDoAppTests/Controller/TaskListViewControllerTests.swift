//
//  TaskListViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Михаил Дмитриев on 11.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import XCTest
@testable import ToDoApp

@available(iOS 13.0, *)
class TaskListViewControllerTests: XCTestCase {
    
    var sut: TaskListViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: String(describing: TaskListViewController.self))
        sut = vc as? TaskListViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Имеем ли TableView
    func testWhenViewIsloadedTableViewNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    //Провайдер
    func testWhenViewIsLoadedDataProviderIsNotNil() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    //Delegate
    func testEhtnViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    //DataSource
    func testEhtnViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    //From Provider
    func testWhenIsLoadedTWDelegateEqualsTVDataSource() {
        XCTAssertEqual(sut.tableView.delegate as? DataProvider,
                       sut.tableView.dataSource as? DataProvider)
    }

}
