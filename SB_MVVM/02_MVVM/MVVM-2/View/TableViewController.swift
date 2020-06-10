//
//  TableViewController.swift
//  MVVM-2
//
//  Created by Михаил Дмитриев on 05.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //Ссылка на ViewModel
    private var viewModel: TableViewViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()        
    }

    // MARK: - Table view data source

    //Количество ячеек в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //ViewModel возвращает количество строк в таблице
        return viewModel?.numberOfRows() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        //Проверка без принудительного извлечения каста типа
        //Проверяем что есть модель
        //Рекомендуется.
        guard let tableViewCell = cell, let viewModel = viewModel else {return UITableViewCell()}
        
        //Геренерируем новую ViewModel
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.viewModel = cellViewModel
        
        return tableViewCell
    }
    
    //Нажатие на ячейку таблицы
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {return}
        //Какая ячейка выделена
        viewModel.selectRow(atIndexPath: indexPath)
        
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    //Передаем модель во 2й Контролер
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else {return}
        
        if identifier == "detailSegue" {
            if let dvc = segue.destination as? DetailViewController{
                dvc.viewModel = viewModel.viewModelForSelectedRow()
            }
        }
    }
}
