//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Mike on 24.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let places = Place.getPlaces()

    // MARK: - Table view data source

    //Возвращает количество строк в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    //Конфигурация ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Приведение ячейки к кастомногу классу
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        //Присваиваем текст из массива ячейкам
        cell.nameLabel.text = places[indexPath.row].name
        cell.locationLabel.text = places[indexPath.row].location
        cell.typeLabel.text = places[indexPath.row].type
        cell.imageOfPlace.image = UIImage.init(named: places[indexPath.row].image)
        //Скругление ImageView
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        //Скругление картинки по скругленному ImageView
        cell.imageOfPlace.clipsToBounds = true
        
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
