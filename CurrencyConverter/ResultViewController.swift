//
//  ResultViewController.swift
//  CurrencyConverter
//
//  Created by VJ's iMAC on 22/06/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import UIKit
import Alamofire

var selectedFromCurrency: String?
var selectedToCurrency: String?

class ResultViewController: UIViewController {
    
    @IBOutlet weak var _tableview: UITableView!
    @IBOutlet weak var answerLbl : UILabel!
    
    var selectedFromCurrency: String?
    var selectedToCurrency: String?
    
    var value : String = String()
    var currencyRatesFetched = [ratesModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        api()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func goTOBaseCurrecyVC() {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func addMoreCurrecyVC() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CompareCurrencyViewController") as! CompareCurrencyViewController
        self.present(secondViewController, animated: true, completion: nil)
        
    }
   

}

extension ResultViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyRatesFetched.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        let indexVal = currencyRatesFetched[indexPath.row].rates
        cell.backgroundColor = #colorLiteral(red: 0.1279955208, green: 0.4278864563, blue: 0.7415625453, alpha: 1)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = indexVal?.allValues.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
extension ResultViewController {
    
    
    func api() {
                
        WSURLSession.sharedInstance.apiGetServiceWithURL(url: "https://api.exchangeratesapi.io/latest?base", isLoader: true, isLoaderHide: true, response: { (responseObj) in
            print(responseObj)
            self.currencyRatesFetched.removeAll()
            let base = responseObj["base"] as? String
            let date = responseObj["date"] as? String
            let rates = responseObj["rates"] as? NSDictionary
            self.currencyRatesFetched.append(ratesModel(base:base, date: date, rates: rates))
            DispatchQueue.main.async {
                self._tableview.reloadData()
            }
            
            self.convert()
            
        }) { (error) in
            print(error)
        }
        
    }
    
    func convert() {
    
            self.answerLbl.text = ""
        if ((self.selectedFromCurrency?.isEmpty) == false) {
                let fetchedRates = self.currencyRatesFetched[0].rates! as NSDictionary
                let fromCurrency = fetchedRates.object(forKey: self.selectedFromCurrency!) as! Float
            let toCurrency = fetchedRates.object(forKey: self.selectedToCurrency!) as! Float
            let inputCurrency = Float(Int(selectedToCurrency ?? "") ?? Int(0.0))
            if Int(inputCurrency) > Int(0) {
                let convertedCurrency = (toCurrency/fromCurrency)*inputCurrency
                    self.answerLbl.text = NSString(format: "%.2f", convertedCurrency) as String
                
                }
                else {
                    self.answerLbl.text = ("Invalid Input")
                }
            }
            else {
                self.answerLbl.text = ("Enter Input Value")
            }
        
    }
    
}
