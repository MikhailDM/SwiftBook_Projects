//
//  PhotosCollectionViewController.swift
//  PhotoTapps
//
//  Created by Михаил Дмитриев on 04.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    let photos = ["dog1", "dog2", "dog3", "dog4", "dog5", "dog6", "dog7", "dog8", "dog9", "dog10", "dog11", "dog12", "dog13", "dog14"]
    
    //Количество ячеек в ряду
    let itemsPerRow: CGFloat = 3
    //Отступы
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        //Другой способ настройки ячеек - каст до UICollectionViewFlowLayout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        //Убираем полоску прокрутки
        collectionView.showsVerticalScrollIndicator = false
         */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Проверяем сегвей
        if segue.identifier == "pickPhotoSegue" {
            //Кастим константу до destination сегвея
            let photoVC = segue.destination as! PhotoViewController
            //Ячейка
            let cell = sender as! PhotoCell
            //Передаем картинку в destination
            photoVC.image = cell.dogImageView.image            
        }        
    }

    
    
//MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        //Имя фото
        let imageName = photos[indexPath.item]
        //Само фото
        let image = UIImage(named: imageName)
        //Настраиваем ячейку
        cell.dogImageView.image = image
        return cell
    }
}




//С помощью данного протокола мы можем конфигурировать Flow Layout
extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    //Размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Общая ширина разрывов горизонтальных
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        //Доступная ширина экрана
        let avaliableWidth = collectionView.frame.width - paddingWidth
        //Ширина одной ячейки
        let widthPerItem = avaliableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    //Отступы до краев
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    //Расстояние между секциями по вертикали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    //Расстояние между секциями по горизонтали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
}

