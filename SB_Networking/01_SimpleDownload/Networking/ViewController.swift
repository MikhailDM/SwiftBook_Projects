//
//  ViewController.swift
//  Networking
//
//  Created by Alexey Efimov on 25/07/2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var getImageButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func getImagePressed(_ sender: Any) {
        
        label.isHidden = true
        getImageButton.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        //Проверка валидности URL
        guard let url = URL(string: "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg") else { return }
        //Сессия
        let session = URLSession.shared
        //Запрос
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                //Обновление UI
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                }
            }
        }.resume()
    }
    
}

