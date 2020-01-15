//
//  ViewController.swift
//  UIKit&SwiftUI
//
//  Created by Алексей Пархоменко on 16/06/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = Post.fetchPosts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Courses"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: CustomCell.reuseId)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseId, for: indexPath) as! CustomCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let detailScreen = DetailScreen(object: post)
        
        let host = UIHostingController(rootView: detailScreen)
        navigationController?.pushViewController(host, animated: true)
    }
    
}



