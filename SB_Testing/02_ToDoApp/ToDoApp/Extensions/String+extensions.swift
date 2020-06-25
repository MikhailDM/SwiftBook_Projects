//
//  String+extensions.swift
//  ToDoApp
//
//  Created by Ivan Akulov on 29/10/2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
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
