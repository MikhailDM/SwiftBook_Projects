//
//  PageViewController.swift
//  UIPageView
//
//  Created by Debash on 29.05.2018.
//  Copyright © 2018 swiftbook.ru. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    let presentScreenContents = [
        "Первая страница презентации, расказывающая о том, что наше приложение из себя предсавляет",
        "Вторая страница презентации, расказывает о какойто удобной фишке приложения",
        "Третья сраница презентации тоже рассказывает о чем то очень интересном",
        "Ну и наконец последняя страница презентации с напутствием в добрый путь =)"
    ]
    
    let emojiArray = ["😉", "🤓", "🧐", "👍"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self

        if let contentPageVC = self.showViewControllerAtIndex(0) {
            setViewControllers([contentPageVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> ContentPageViewController? {
        
        guard index >= 0 && index < presentScreenContents.count else {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "appAlreadeSeen")
            dismiss(animated: false, completion: nil)
            return nil
        }
        
        guard let contentPageViewController = storyboard?.instantiateViewController(
            withIdentifier: "ContentPageViewController") as? ContentPageViewController else { return nil }
        
        contentPageViewController.presenText = presentScreenContents[index]
        contentPageViewController.emoji = emojiArray[index]
        contentPageViewController.currentPage = index
        contentPageViewController.numberOfPages = presentScreenContents.count
        
        return contentPageViewController
    }

}

extension PageViewController: UIPageViewControllerDataSource {
    
    // Переход на одну страницу назад
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ContentPageViewController).currentPage
        pageNumber -= 1
        return showViewControllerAtIndex(pageNumber)
    }
    
    // Перход на одну страницу вперед
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ContentPageViewController).currentPage
        pageNumber += 1
        return showViewControllerAtIndex(pageNumber)
    }
}
