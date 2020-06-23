//
//  DetailViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Михаил Дмитриев on 23.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import XCTest
import CoreLocation

import XCTest
@testable import ToDoApp

class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Наличие элементов
    func testHasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }
    
    func testHasDateLabel() {
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    func testHasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    func testHasMapView() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    private func setupTaskAndAppearanceTransition() {
        let coordinate = CLLocationCoordinate2D(latitude: 54.74801923, longitude: 56.01103876)
        let location = Location(name: "Baz", coordinate: coordinate)
        let date = Date(timeIntervalSince1970: 1546300800)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        sut.task = task
        
        //Фейковая передачи информации после загрузки
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }
    
    //Передача информации. Изменение Title
    func testSettingTaskSetsTitleLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    //Передача информации. Изменение Description
    func testSettingTaskSetsDescriptionLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    //Передача информации. Изменение Location
    func testSettingTaskSetsLocationLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    //Дата
    func testSettingTaskSetsDateLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.dateLabel.text, "01.01.19")
    }
    
    //Указание правильной локации
    func testSettingTaskSetsMapView() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude,
                       54.74801923,
                       accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude,
                       56.01103876,
                       accuracy: 0.001)
    }
}
