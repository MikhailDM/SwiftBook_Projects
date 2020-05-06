//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by Михаил Дмитриев on 04.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    //Массив обьектов
    var objects = [
        Emoji(emoji: "🥰", name: "Love", description: "Let's love each other", isFavourite: false),
        Emoji(emoji: "⚽️", name: "Football", description: "Let's play together", isFavourite: false),
        Emoji(emoji: "🐱", name: "Cat", description: "Cats is cuttiest animals", isFavourite: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        //Заголовок контроллера
        self.title = "Emoji Reader"
        //Кнопка редактирования
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    //Сегвей на данный экран
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        //Проверка на id
        guard segue.identifier == "saveSegue" else { return }
        //Доступ к source конроллеру
        let sourceVC = segue.source as! NewEmojiTableViewController
        //Обьект
        let emoji = sourceVC.emoji
        //Проверка на существование текущей строки если мы редактируем и не создаем новую
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            //Присваиваем существующему массиву отредактированный обьект
            objects[selectedIndexPath.row] = emoji
            //Перезагружаем текущую строку
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        //Если же создаем новый обьект
        } else {
            //Индекс куда вставлять
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            //Добавляем эмоджи в массив
            objects.append(emoji)
            //Перезагружаем строку
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    //Сегвей для редактирования ячейки. передает данные на второй экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else { return }
        //Индекс нажатой ячейки
        let indexPath = tableView.indexPathForSelectedRow!
        //Обьект нажатой ячейки
        let emoji = objects[indexPath.row]
        //Добираемся до контроллера назначения
        let navigationVC = segue.destination as! UINavigationController
        //Верхний контроллер
        let newEmojiVC = navigationVC.topViewController as! NewEmojiTableViewController
        //Передаем обьект
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
    }
        
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    //Ячейка таблицы
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Кастим ячейку до нашего класса. Регистрирация не нужна, так как настройка из сториборда
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        //Обьект из массива
        let object = objects[indexPath.row]
        //Вызываем функцию настройки, передаем обьект в ячейку
        cell.set(object: object)
        
        return cell
    }
    
    //Функция, которая изменяет тип редактирования
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //Действия при определенных типах редактирования
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Удаляем обьект из массива и из TableView
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //Позволяет перемещать ячейки
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //Логика перемещения
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Фиксируем удаленную строку
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        //Вставляем строку
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        //Перегружаем список
        tableView.reloadData()
    }
    //Левый свайп
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }        
    //Действия при левом свайпе - удаление
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        //Настройки отображения кнопки удаления
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    //Действия при левом свайпе - лайк
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            object.isFavourite.toggle()
            self.objects[indexPath.row] = object
            completion(true)
        }
        //Настройки отображения кнопки лайка
        action.backgroundColor = object.isFavourite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
