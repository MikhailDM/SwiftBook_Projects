//
//  TableViewController.swift
//  CoreDataDemo
//
//  Created by Mike on 20.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    //Массив задач
    var tasks = [Task]()

    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        //Алерт контроллер по нажатию
        let ac = UIAlertController(title: "Add Task", message: "Add new task", preferredStyle: .alert)
        //Кнопка
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            let tf = ac.textFields?.first
            if let newTaskTitle = tf?.text {
                self.saveTask(withTitle: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        //Кнопка отмены
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        //Текстоое поля ввода
        ac.addTextField {
            textField in
        }
        
        //Добавляем действия в контроллер и показываем его
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func removeAllPressed(_ sender: UIBarButtonItem) {
        //Алерт контроллер по нажатию
        let ac = UIAlertController(title: "Remove All", message: "Удалить все задачи", preferredStyle: .alert)
        //Кнопка
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            self.delAllTasks()
        }
        //Кнопка отмены
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        
        //Добавляем действия в контроллер и показываем его
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    
    
// MARK: - МЕТОД СОХРАНЕНИЯ В CORE DATA
    private func saveTask(withTitle title: String) {
        //Получаем контекст
        let context = getContext()
        //Извлекаем сущность
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        //Достаем обьект
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.title = title
        //Сохраняем обьект
        do {
            try context.save()
            tasks.append(taskObject)
            //self.tableView.reloadData()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    private func delAllTasks() {
        //Метод удаления всего из базы
        //Получаем контекст
        let context = getContext()
        //Запрос
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        //Удаляем все данные
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        //Сохраняем обьект
        do {
            try context.save()
            //Очищаем список
            tasks.removeAll()
            self.tableView.reloadData()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    

    
    
// MARK: - LOADING
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Получаем контекст
        let context = getContext()
        //Запрос
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        //Сортировка при загрузке
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //Присваиваем нашему массиву данные из CoreData
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    //Получение контекста
    private func getContext() -> NSManagedObjectContext {
        //Ссылка на делегат
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //Контекст
        return appDelegate.persistentContainer.viewContext
    }
   
    
    

// MARK: - Table view data source

    //Количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Конкретная запись в конкретную ячейку
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    //Создает ячейку
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        //Помещяем в конкретную ячейку конкретную запись
        let task = tasks[indexPath.row]
        //Присваиваем title
        cell.textLabel?.text = task.title
        return cell
    }
}
