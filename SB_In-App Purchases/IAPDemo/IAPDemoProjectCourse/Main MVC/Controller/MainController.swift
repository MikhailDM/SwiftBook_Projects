//
//  MainController.swift
//  IAPDemoProject
//
//  Created by Ivan Akulov on 26/10/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit


class MainController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension MainController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Настройки"
        }
        return "Встроенные покупки"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 2 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.mainCell, for: indexPath)
        let section = indexPath.section
        
        if section == 0 {
            switch indexPath.row {
            case 0: cell.textLabel?.text = "Какие-то настройки"
            case 1: cell.textLabel?.text = "Еще какие-то настройки"
            default: break
            }
        } else {
            cell.textLabel?.text = "Перейти ко встроенным покупкам"
        }
        return cell
    }
}


extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        if section == 1 {
            performSegue(withIdentifier: "segue", sender: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}











