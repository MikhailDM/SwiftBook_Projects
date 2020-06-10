//
//  DetailViewModelType.swift
//  MVVM-2
//
//  Created by Михаил Дмитриев on 05.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation

protocol DetailViewModelType {
    var description: String { get }
    var age: Box<String?> { get }
}
