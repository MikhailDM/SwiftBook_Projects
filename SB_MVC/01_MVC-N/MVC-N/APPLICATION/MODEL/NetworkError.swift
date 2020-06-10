//
//  NetworkError.swift
//  MVC-N
//
//  Created by Михаил Дмитриев on 06.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case failInternetError
    case noInternetConnection
}
