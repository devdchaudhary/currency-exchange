//
//  SaveConfirmViewController.swift
//  Currency Exchange
//
//  Created by Devanshu on 24/07/18.
//  Copyright © 2018 Devanshu. All rights reserved.
//

import UIKit
import CoreData

class SaveConfirmViewController: UIViewController, UITextFieldDelegate {
    
    var usdVal: Float!
    var eurVal: Float!
    var gbpVal: Float!
    var inrVal: Float!
    var appDel: AppDelegate  {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var sharedContext: NSManagedObjectContext {
        return appDel.managedObjectContext!
    }
        
    override func viewDidLoad() {

        super.viewDidLoad()
        
    }
    
    @IBAction func saveConversion(_ sender: UIButton) {
        
        let dictionary = [
            "usdVal": usdVal,
            "eurVal": eurVal,
            "gbpVal": gbpVal,
            "inrVal": inrVal,
            ] as [String : Any]
        _ = Currencies(dictionary: dictionary as [String : AnyObject], context: sharedContext)
        appDel.saveContext()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelSave(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}

