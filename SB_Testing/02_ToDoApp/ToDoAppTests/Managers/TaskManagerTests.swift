//
//  TaskManagerTests.swift
//  ToDoAppTests
//
//  Created by Михаил Дмитриев on 11.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import XCTest
@testable import ToDoApp

class TaskManagerTests: XCTestCase {
    
    var sut: TaskManager!

    override func setUpWithError() throws {
       sut = TaskManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testInitTaskManagerWithZeroTask() {
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    func testInitTaskManagerWithZeroDoneTask() {
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    func testAddTaskIncrementTasksCount() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    func testTaskAtIndexIsAddedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        let returnedTask = sut.task(at: 0)
        
        XCTAssertEqual(task.title, returnedTask.title)
    }
    
    //Проверка на количество задач после выполнения задачи
    func testCheckTaskAtIndexChangesCounts() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.tasksCount, 0)
        XCTAssertEqual(sut.doneTasksCount, 1)
    }
    
    func testCheckedTaskRemovedFromTasks() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
        
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        
        sut.checkTask(at: 0)
        XCTAssertEqual(sut.task(at: 0).title, "Bar")
    }
    
    func testDoneTestAtReturnsCheckedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(returnedTask.title, task.title)
    }
    

}
