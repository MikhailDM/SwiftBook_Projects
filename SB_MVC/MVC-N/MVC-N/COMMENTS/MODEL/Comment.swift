//
//  Comment.swift
//  MVC-N
//
//  Created by Михаил Дмитриев on 06.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation
//Posts from:
//https://jsonplaceholder.typicode.com/posts/1/comments
struct Comment {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    //Failable initializer. Извлекаем данные
    init?(dict: [String: AnyObject]) {
        guard
            let postId = dict["postId"] as? Int,
            let id = dict["id"] as? Int,
            let name = dict["name"] as? String,
            let email = dict["email"] as? String,
            let body = dict["name"] as? String else { return nil }
        
        self.postId = postId
        self.id = id
        self.name = name
        self.email = email
        self.body = body
            
    }
}
