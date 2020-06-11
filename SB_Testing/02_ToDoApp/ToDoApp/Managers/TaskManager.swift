//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Михаил Дмитриев on 11.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

class TaskManager {
    var tasksCount: Int {
        return tasks.count
    }
    var doneTasksCount: Int {
        return doneTasks.count
    }
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    func add(task: Task) {
        tasks.append(task)
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }
    
    func checkTask(at index: Int) {
        let task = tasks.remove(at: index)
        doneTasks.append(task)
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTasks[index]
    }
}
