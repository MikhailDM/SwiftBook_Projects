//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Михаил Дмитриев on 11.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

class TaskManager {
    //Количество задач
    var tasksCount: Int {
        return tasks.count
    }
    //Количество завершенных задач
    var doneTasksCount: Int {
        return doneTasks.count
    }
    
    //Массивы задач
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    //Добавление задачи
    func add(task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        }        
    }
    
    //Задача по индексу
    func task(at index: Int) -> Task {
        return tasks[index]
    }
    
    //Выполнить задачу
    func checkTask(at index: Int) {
        let task = tasks.remove(at: index)
        doneTasks.append(task)
    }
    
    //Выполненая задача по индексу
    func doneTask(at index: Int) -> Task {
        return doneTasks[index]
    }
    
    //Обнуление массивов
    func removeAll() {
        tasks.removeAll()
        doneTasks.removeAll()
    }
}
