//
//  HistoryViewController.swift
//  Currency Exchange
//
//  Created by Devanshu on 18/07/18.
//  Copyright © 2018 Devanshu. All rights reserved.
//

import UIKit
import CoreData

class ConversionHistoryViewController: UITableViewController {
    
    var appDel: AppDelegate  {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var sharedContext: NSManagedObjectContext {
        return appDel.managedObjectContext!
    }
    
    var fetchedConversions: [Currencies]!
    
    override func viewWillAppear(_ animated: Bool) {
        
    fetchedConversions = fetchAllConversions()
        
     self.tableView.reloadData()
        
    }
    
    func fetchAllConversions() -> [Currencies]! {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Currencies")
        var results: [Currencies]!
        do {
            results = try sharedContext.fetch(request) as! [Currencies]
        } catch {
            results = nil
        }
        return results
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: CurrencyCell, indexPath: IndexPath) {
        
        cell.usdValue.text = "\(fetchedConversions[indexPath.row].usdValue)"
        cell.euroLabel.text = "\(fetchedConversions[indexPath.row].eurValue)"
        cell.poundLabel.text = "\(fetchedConversions[indexPath.row].gbpValue)"
        cell.rupeeLabel.text = "\(fetchedConversions[indexPath.row].inrValue)"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchedConversions == nil {
            return 0
        }
        return fetchedConversions.count
    }

}
