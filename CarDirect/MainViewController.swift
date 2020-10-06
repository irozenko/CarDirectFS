//
//  MainViewController.swift
//  CarDirect
//
//  Created by Apple on 03.10.2020.
//  Copyright © 2020 Ilya Rozenko. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {

   
 
    var cars: Results<CarInfo>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cars = realm.objects(CarInfo.self)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cars.isEmpty ? 0 : cars.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.nameLable.text = cars[indexPath.row].model
        cell.locationLabel.text = cars[indexPath.row].brand

        return cell
    }
    
    // Table view delegate
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let car = cars[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            StorageManager.deleteObject(car)
            tableView.deleteRows(at: [indexPath], with: .automatic)
    }
        return [deleteAction]
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let car = cars[indexPath.row]
            let newCarVC = segue.destination as! NewCarViewController
            newCarVC.currentCar = car
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newCarVC = segue.source as? NewCarViewController else { return }
        
        newCarVC.saveCar()
        tableView.reloadData()
    }
}
