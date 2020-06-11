//
//  TaskManagerTests.swift
//  ToDoAppTests
//
//  Created by Михаил Дмитриев on 11.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import XCTest
//Наш проект
@testable import ToDoApp

class TaskManagerTests: XCTestCase {
    //Менеджер
    var sut: TaskManager!
    
    override func setUpWithError() throws {
        //Инициализация менеджера
        sut = TaskManager()
    }
    
    override func tearDownWithError() throws {
        //Деинициализация менеджера
        sut = nil
    }
    
    //Проверка количества задач при инициализации
    func testInitTaskManagerWithZeroTask() {
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    //Проверка количества выполненных задач при инициализации
    func testInitTaskManagerWithZeroDoneTask() {
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    //Количество задач после создания обьекта
    func testAddTaskIncrementTasksCount() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    //Проверка функции задачи по индексу
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
    
    //Проверка массива задач после завершения одной задачи
    func testCheckedTaskRemovedFromTasks() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
        
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        
        sut.checkTask(at: 0)
        XCTAssertEqual(sut.task(at: 0), secondTask)
    }
    
    //Проверка массива выполненых задач
    func testDoneTestAtReturnsCheckedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(returnedTask, task)
    }
    
    //Удаляем весь массив
    func testRemoveAllResultsCountBeZero() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Bar"))
        
        sut.checkTask(at: 0)
        
        sut.removeAll()
        
        XCTAssertTrue(sut.tasksCount == 0)
        XCTAssertTrue(sut.doneTasksCount == 0)
    }
    
    //Проверка на повторяющиеся значения
    //Из за того что даты при инициализации различаются - сравнение идем по другим параметрам
    func testAddingSameObjectDoesNotIncrementCount() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Foo"))
        
        XCTAssertTrue(sut.tasksCount == 1 )
    }
    
}
