//
//  TaskTests.swift
//  ToDoAppTests
//
//  Created by Михаил Дмитриев on 11.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import XCTest
@testable import ToDoApp

class TaskTests: XCTestCase {
    //Создание  обьекта
    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task)
    }
    //Создание  обьекта с описанием
    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertNotNil(task)
    }
    //Создание  обьекта и проверка поля task
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertEqual(task.title, "Foo")
    }
    //Создание  обьекта и проверка поля task и description
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertEqual(task.description, "Bar")
    }
    //Установилась ли дата
    func testTaskInitWithDate() {
        let task = Task(title: "Foo")
        XCTAssertNotNil(task.date)
    }
    
}
