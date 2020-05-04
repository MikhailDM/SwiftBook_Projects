//
//  PhotoViewController.swift
//  PhotoTapps
//
//  Created by Михаил Дмитриев on 04.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Присваивам фото при загрузке
        photoImageView.image = image
    }
   
    
//MARK: - ПАНЕЛЬ РАСШАРИВАНИЯ ФОТО
    @IBAction func sharedAction(_ sender: UIButton) {
        //Функционал панели
        let sharedController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        //Следим за выполнением поста
        sharedController.completionWithItemsHandler =  { _, bool, _, _ in
            if bool {
                print("УСПЕШНО!")
            }
        }
        
        //Показываем панель
        present(sharedController, animated: true, completion: nil)
    }
}
