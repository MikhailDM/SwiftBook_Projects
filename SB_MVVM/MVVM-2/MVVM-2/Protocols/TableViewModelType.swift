//
//  TableViewModelType.swift
//  MVVM-2
//
//  Created by Михаил Дмитриев on 05.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation
//Требования к ViewModel TableViewController
protocol TableViewViewModelType {
    //Количество ячеек
    func numberOfRows() -> Int
    //Метод генерирует ViewModel для каждой ячейки
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    
    func viewModelForSelectedRow() -> DetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
}
