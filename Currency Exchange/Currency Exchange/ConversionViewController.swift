//
//  ViewController.swift
//  Currency Exchange
//
//  Created by Devanshu on 18/07/18.
//  Copyright © 2018 Devanshu. All rights reserved.
//

import UIKit
import CoreData

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var Refresh: UIButton!
    @IBOutlet var activityindicator: UIActivityIndicatorView!
    @IBOutlet var usdInputLabel: UILabel!
    @IBOutlet var eurOutputLabel: UILabel!
    @IBOutlet var gbpOutputLabel: UILabel!
    @IBOutlet var inrOutputLabel: UILabel!
    var quotes: [String:AnyObject]!
    var decimalDisabled = false
    var enableConversion = false
    var defaults = {
        return UserDefaults.standard
    }()
    
    var usdtoeurquote = ExchangeRate.init(fromCode: "1. From_Currency Code", fromName: "2. From_Currency Name", toCode: "3. To_Currency Code", toName: "4. To_Currency Name", rate: "5. Exchange Rate", lastRefreshed: "6. Last Refreshed", timeZone: "7. Time Zone") as? Float
    
    var usdtogbpquote = ExchangeRate.init(fromCode: "1. From_Currency Code", fromName: "2. From_Currency Name", toCode: "3. To_Currency Code", toName: "4. To_Currency Name", rate: "5. Exchange Rate", lastRefreshed: "6. Last Refreshed", timeZone: "7. Time Zone") as? Float
    
    var usdtoinrquote = ExchangeRate.init(fromCode: "1. From_Currency Code", fromName: "2. From_Currency Name", toCode: "3. To_Currency Code", toName: "4. To_Currency Name", rate: "5. Exchange Rate", lastRefreshed: "6. Last Refreshed", timeZone: "7. Time Zone") as? Float
    
    override func viewDidLoad() {
        usdQUotesRequest()
        activityindicator.startAnimating()
        Refresh.isEnabled = false
    }
    
    func stopActivityIndicator() {
        
        self.activityindicator.stopAnimating()
        self.activityindicator.isHidden = true
        
    }

    func displayAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func usdQUotesRequest() {
        
        USDClient().USDtoEUR(from: "USD", to: "EUR") { exchangeRate, error in
            
            if let exchangeRate = exchangeRate {
                self.usdtoeurquote = exchangeRate.floatRate
                DispatchQueue.main.async {
                    self.stopActivityIndicator()
                    self.Refresh.isEnabled = true
                    self.saveQuotesToUserDefaults(self.usdtoeurquote!, key: "EUR")
                    debugPrint("EUR retrieved")
                }
            } else {
                DispatchQueue.main.async {
                    self.displayAlert("Alert!", message: "Latest EUR rate not revrieved, using an old one.")
                    self.stopActivityIndicator()
                    self.Refresh.isEnabled = true
                    self.usdtoeurquote = self.accessQuotesFromUserDefaults("EUR")
                    debugPrint("EUR not retrieved")
                }
            }
            self.enableConversion = true
        }
        
        USDClient().USDtoGBP(from: "USD", to: "GBP") { exchangeRate, error in
            
            if let exchangeRate = exchangeRate {
                self.usdtogbpquote = exchangeRate.floatRate
                DispatchQueue.main.async {
                    self.stopActivityIndicator()
                    self.Refresh.isEnabled = true
                    self.saveQuotesToUserDefaults(self.usdtogbpquote!, key: "GBP")
                    debugPrint("GBP retrieved")
                }
            } else {
                DispatchQueue.main.async {
                    self.displayAlert("Alert!", message: "Latest GBP rate not revrieved, using an old one.")
                    self.stopActivityIndicator()
                    self.Refresh.isEnabled = true
                    self.usdtogbpquote =  self.accessQuotesFromUserDefaults("GBP")
                    debugPrint("Latest GBP rate not retrieved")
                }
            }
            self.enableConversion = true
        }
        
        USDClient().USDtoINR(from: "USD", to: "INR") { exchangeRate, error in
            
            if let exchangeRate = exchangeRate {
                self.usdtoinrquote = exchangeRate.floatRate
                DispatchQueue.main.async {
                    self.stopActivityIndicator()
                    self.Refresh.isEnabled = true
                    self.saveQuotesToUserDefaults(self.usdtoinrquote!, key: "INR")
                    debugPrint("INR retrieved")
                }
            } else {
                DispatchQueue.main.async {
                  self.displayAlert("Alert!", message: "Latest INR rate not revrieved, using an old one.")
                    self.stopActivityIndicator()
                    self.Refresh.isEnabled = true
                    debugPrint("INR not retrieved")
                    self.usdtoinrquote = self.accessQuotesFromUserDefaults("INR")
                }
            }
            self.enableConversion = true
        }
        
    }
    
    func saveQuotesToUserDefaults(_ value: Float, key: String) {
        defaults.set(value, forKey: key)
    }
    
    func removeAllKeysForUserDefaults() {
        defaults.removeObject(forKey: "EUR")
        defaults.removeObject(forKey: "GBP")
        defaults.removeObject(forKey: "INR")
    }
    
    func accessQuotesFromUserDefaults(_ key: String) -> Float {
        let quote = defaults.float(forKey: key)
        if quote != 0 {
            return quote
        }
        else {
            switch(key) {
            case "GBP": return defaults.float(forKey: "GBP")
                
            case "EUR": return defaults.float(forKey: "EUR")
                
            case "INR": return defaults.float(forKey: "INR")
                
            default: return 0
            }
        }
    }
    
    @IBAction func appendDigit(_ sender: UIButton) {
        if enableConversion {
            if usdInputLabel.text == "0" {
                usdInputLabel.text = sender.titleLabel!.text!
            }
            else {
                usdInputLabel.text = "\(usdInputLabel.text!)\(sender.titleLabel!.text!)"
            }
            convertToCurrencies()
            usdQUotesRequest()
        }
        else {
            displayAlert("Currently Downloading New Rates", message: "Please wait a moment before initating any conversion.")
            if sender.titleLabel?.text == "." {
                decimalDisabled = false
            }
        }
    }
    
    @IBAction func disableDecimalOnFirstUse(_ sender: UIButton) {
        if !decimalDisabled {
            decimalDisabled = true
            appendDigit(sender)
        }
        else {
            displayAlert("Invalid Decimal Point Insertion", message: "Adding another decimal would make the USD value invalid.")
        }
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        if enableConversion {
            usdInputLabel.text = "0"
            decimalDisabled = false
            convertToCurrencies()
        }
    }
    
    @IBAction func deleteValue(_ sender: UIButton) {
        if enableConversion {
            if (usdInputLabel.text!).count == 1 {
                allClear(sender)
                decimalDisabled = false
                return
            }
            if usdInputLabel.text == "0" {
                displayAlert("Unable to Delete", message: "There is nothing to delete.")
            }
            else {
                let index = usdInputLabel.text?.index(before: (usdInputLabel.text?.endIndex)!)
                let lastChar = usdInputLabel.text!.remove(at: index!)
                if lastChar == "." {
                    decimalDisabled = false
                }
                convertToCurrencies()
            }
        }
        else {
            displayAlert("Currently Downloading New Rates", message: "Please wait a moment before initating any conversion.")
        }
    }
    
    @IBAction func saveConversion(_ sender: UIButton) {
        if usdInputLabel.text != "0" {
            let controller = storyboard?.instantiateViewController(withIdentifier: "SavedHistory") as! SaveConfirmViewController
            controller.usdVal = convertStringToFloat(usdInputLabel.text!)
            controller.eurVal = convertStringToFloat(eurOutputLabel.text!)
            controller.gbpVal = convertStringToFloat(gbpOutputLabel.text!)
            controller.inrVal = convertStringToFloat(inrOutputLabel.text!)
            self.present(controller, animated: true, completion: nil)
        }
        else {
            displayAlert("No Conversion Made", message: "You cannot save because you have not made a conversion.")
        }
    }
    
    @IBAction func refreshRates(_ sender: UIButton) {
        displayAlert("Alert!", message: "Rates Refreshed")
        usdQUotesRequest()
        activityindicator.isHidden = false
        activityindicator.startAnimating()
        Refresh.isEnabled = false
    }
    
    func convertStringToFloat(_ string: String) -> Float {
        return (string as NSString).floatValue
    }
    
    func convertToCurrencies() {
        
        let usdVal = (usdInputLabel.text! as NSString).floatValue
        
        let euroValue = usdVal * usdtoeurquote!
        eurOutputLabel.text = String(format: "%.2f", euroValue)
        
        let gbpVal = usdVal * usdtogbpquote!
        gbpOutputLabel.text = String(format: "%.2f", gbpVal)
        
        let inrVal = usdVal * usdtoinrquote!
        inrOutputLabel.text = String(format: "%.2f", inrVal)
        
    }
    
}





