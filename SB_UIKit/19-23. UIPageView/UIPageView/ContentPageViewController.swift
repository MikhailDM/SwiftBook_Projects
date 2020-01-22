//
//  ContentPageViewController.swift
//  UIPageView
//
//  Created by Debash on 29.05.2018.
//  Copyright © 2018 swiftbook.ru. All rights reserved.
//

import UIKit

class ContentPageViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var presenText = ""
    var emoji = ""
    var currentPage = 0 // Номер текущей страницы
    var numberOfPages = 0 // Количество страниц
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = presenText
        emojiLabel.text = emoji
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
    }

}
