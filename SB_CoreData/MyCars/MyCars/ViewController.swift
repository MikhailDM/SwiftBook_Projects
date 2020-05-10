//
//  ViewController.swift
//  MyCars
//
//  Created by Ivan Akulov on 08/02/20.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
//MARK: - OBJECTS
    //Контекст
    var context: NSManagedObjectContext!
    //Переменная текущей машины
    var car: Car!
    //Формат даты
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }()

    
//MARK: - OUTLETS
    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet {
            updateSegmentedControl()
            segmentedControl.selectedSegmentTintColor = .white
            let whiteTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            let blackTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            UISegmentedControl.appearance().setTitleTextAttributes(whiteTitleTextAttributes, for: .normal)
            UISegmentedControl.appearance().setTitleTextAttributes(blackTitleTextAttributes, for: .selected)
        }
    }
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var lastTimeStartedLabel: UILabel!
    @IBOutlet weak var numberOfTripsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var myChoiceImageView: UIImageView!
 
    
//MARK: - ACTIONS
    //Выбор марки
    @IBAction func segmentedCtrlPressed(_ sender: UISegmentedControl) {
        updateSegmentedControl()
    }
    //Метод обновления UI
    private func updateSegmentedControl() {
        //Заполнение UI из Core Data
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        let mark = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        fetchRequest.predicate = NSPredicate(format: "mark != %@", mark!)
        //Извлечение и заполнение
        do {
            let results = try context.fetch(fetchRequest)
            car = results.first
            insertDataFrom(selectedCar: car!)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //Запуска двигателя
    @IBAction func startEnginePressed(_ sender: UIButton) {
        car.timesDriven += 1
        car.lastStarted = Date()
        //Сохранение
        do {
            try context.save()
            insertDataFrom(selectedCar: car!)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //Нажатие на рейтинг
    @IBAction func rateItPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Rate It", message: "Rate this car", preferredStyle: .alert)
        let rateAction = UIAlertAction(title: "Rate", style: .default) { (action) in
            if let text = alertController.textFields?.first?.text {
                self.update(rating: (text as NSString).doubleValue)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addTextField { (textField) in
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(rateAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    //Функция обновления рейтинга
    private func update(rating: Double) {
        car.rating = rating
        //Сохраняем текущее значение
        do {
            try context.save()
            insertDataFrom(selectedCar: car!)
        } catch let error as NSError {
            let alertController = UIAlertController(title: "Wrog Value", message: "Wrong input", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            print(error.localizedDescription)
        }
    }

    
//MARK: - ЗАПОЛНЕНИЕ UI
    private func insertDataFrom(selectedCar car: Car) {
        carImageView.image = UIImage(data: car.imageData!)
        markLabel.text = car.mark
        modelLabel.text = car.model
        myChoiceImageView.isHidden = !(car.myChoice)
        ratingLabel.text = "Rating: \(car.rating) / 10"
        numberOfTripsLabel.text = "Number of trips: \(car.timesDriven)"
        
        lastTimeStartedLabel.text = "Last time started: \(dateFormatter.string(from: car.lastStarted!))"
        segmentedControl.backgroundColor = car.tintColor as? UIColor
    }
    
    
    
    
//MARK: - ПОЛУЧЕНИЕ ДАННЫХ ИЗ ФАЙЛА
    private func getDataFromFile() {
        //Проверка на первый запуск
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mark != nil")
        var records = 0
        do {
            records = try context.count(for: fetchRequest)
            print("Is Data there already?")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        guard records == 0 else { return }
        
        
        //Путь к файлу
        guard let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
            //Массив из списка
            let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
        //Перебор массива
        for dictionary in dataArray {
            //Сущность
            let entity = NSEntityDescription.entity(forEntityName: "Car", in: context)
            //Обьект сущности
            let car = NSManagedObject(entity: entity!, insertInto: context) as! Car
            
            //Словарь данных о машине
            let carDictionary = dictionary as! [String : AnyObject]
            car.mark = carDictionary["mark"] as? String
            car.model = carDictionary["model"] as? String
            car.rating = carDictionary["rating"] as! Double
            car.lastStarted = carDictionary["lastStarted"] as? Date
            car.timesDriven = carDictionary["timesDriven"] as! Int16
            car.myChoice = carDictionary["myChoice"] as! Bool
            
            //Изображения
            let imageName = carDictionary["imageName"] as? String
            let image = UIImage(named: imageName!)
            let imageData = image!.pngData()
            car.imageData = imageData
            
            //Цвет
            if let colorDictionary = carDictionary["tintColor"] as? [String : Float] {
                car.tintColor = getColor(colorDictionary: colorDictionary)
            }
            
        }
    }
    //Метод возвращения цвета
    private func getColor(colorDictionary: [String : Float]) -> UIColor {
        guard let red = colorDictionary["red"],
        let green = colorDictionary["green"],
            let blue = colorDictionary["blue"] else { return UIColor() }
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: 1.0)
    }

    
    
    
//MARK: - LOADING
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromFile()
    }
}

