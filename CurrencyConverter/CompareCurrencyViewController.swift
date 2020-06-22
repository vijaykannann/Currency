
//
//  CompareCurrencyViewController.swift
//  CurrencyConverter
//
//  Created by VJ's iMAC on 22/06/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import UIKit

class CompareCurrencyViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    fileprivate let pickerView = ToolbarPickerView()
    
    var titles = ["AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK",
    "GBP", "HKD", "HRK", "HUF", "IDR", "ILS", "INR", "JPY",
    "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN", "RON",
    "RUB", "SEK","SGD", "THB", "TRY", "USD", "ZAR"]
    
    var choosenValue = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.inputView = self.pickerView
        self.textField.inputAccessoryView = self.pickerView.toolbar
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self
        self.pickerView.reloadAllComponents()
    }
    
    @IBAction func nextVC() {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
               self.present(secondViewController, animated: true, completion: nil)
        
    }
    
}

extension CompareCurrencyViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.titles.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.titles[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textField.text = self.titles[row]
    }
}

extension CompareCurrencyViewController: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        selectedToCurrency = self.titles[row]
        self.textField.resignFirstResponder()
    }

    func didTapCancel() {
        self.textField.text = nil
        self.textField.resignFirstResponder()
    }
}

