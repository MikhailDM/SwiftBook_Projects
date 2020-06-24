//
//  String+extensions.swift
//  ToDoApp
//
//  Created by Михаил Дмитриев on 24.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

extension String {
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "~!@#$%^&*()-+=[]\\}{,./?><").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        return encodedString
    }
}
