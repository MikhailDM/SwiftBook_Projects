//
//  DetailViewController.swift
//  MVVM-2
//
//  Created by Михаил Дмитриев on 05.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    var viewModel: DetailViewModelType?
    
    //Настраиваем экран
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let viewModel = viewModel else { return }
        self.textLabel.text = viewModel.description        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.age.bind { [unowned self] in
            guard let string = $0 else { return }
            self.textLabel.text = string
        }
        
        delay(delay: 3) { [unowned self] in
            //ИЗМЕНЕНИЕ ЗНАЧЕНИЯ БЕЗ ПРЯМОГО ДОСТУПА
            self.viewModel?.age.value = "some new value"
        }
        
    }
    
    //Метод отсрочки перед выполнением кода
    private func delay(delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + delay) {
            closure()
        }
    }
}
