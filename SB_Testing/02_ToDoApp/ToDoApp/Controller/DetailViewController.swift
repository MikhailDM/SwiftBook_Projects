//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by Михаил Дмитриев on 23.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    var task: Task!
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.titleLabel.text = task.title
        self.descriptionLabel.text = task.description
        self.locationLabel.text = task.location?.name
        self.dateLabel.text = dateFormatter.string(from: task.date)
        //Координаты
        if let coordinate = task.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: 100,
                                            longitudinalMeters: 100)
            mapView.region = region
        }
    }
}
