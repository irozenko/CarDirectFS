//
//  NewCarViewController.swift
//  CarDirect
//
//  Created by Apple on 04.10.2020.
//  Copyright © 2020 Ilya Rozenko. All rights reserved.
//

import UIKit

class NewCarViewController:UITableViewController {
    
    var currentCar: CarInfo?
    
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var brandName: UITextField!
    @IBOutlet weak var modelName: UITextField!
    @IBOutlet weak var carBody: UITextField!
    @IBOutlet weak var yearOfCarManufacture: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        
        brandName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        modelName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
    }
    // Скрываем клавиатуру по тапу
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        view.endEditing(true)
        }
    
    
    
    func saveCar() {
        
        let newCar = CarInfo(model: modelName.text!,
                             brand: brandName.text!,
                             type: carBody.text,
                             year: yearOfCarManufacture.text)
        if currentCar != nil {
            try! realm.write {
                currentCar?.model = newCar.model
                currentCar?.brand = newCar.brand
                currentCar?.type = newCar.type
                currentCar?.year = newCar.year
            }
        } else {
        StorageManager.saveObject(newCar)
        }
    }
    
    private func setupEditScreen () {
        if currentCar != nil {
            
            setupNavigationBar()
            
            modelName.text = currentCar?.model
            brandName.text = currentCar?.brand
            carBody.text = currentCar?.type
            yearOfCarManufacture.text = currentCar?.year
        }
    }
    
    private func setupNavigationBar () {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentCar?.model
        saveButton.isEnabled = true
    }
    
    @IBAction func cancelAction(_ sender: Any) {
       
        dismiss(animated: true)
        
    }
    
}

    // Text field delegate

    extension NewCarViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if brandName.text?.isEmpty == false && modelName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
