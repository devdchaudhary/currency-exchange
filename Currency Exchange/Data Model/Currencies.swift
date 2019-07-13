//
//  CurrencyStats.swift
//  Currency Exchange
//
//  Created by Devanshu on 18/07/18.
//  Copyright © 2018 Devanshu. All rights reserved.
//

import Foundation
import CoreData

@objc(Currencies)

public class Currencies: NSManagedObject {
    
    @NSManaged var usdValue: NSNumber
    @NSManaged var eurValue: NSNumber
    @NSManaged var gbpValue: NSNumber
    @NSManaged var inrValue: NSNumber
  
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        
        super.init(entity: entity, insertInto: context)
    }
    
    init(dictionary: [String:AnyObject], context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Currencies", in: context)!
        super.init(entity: entity, insertInto: context)
        
        usdValue = dictionary["usdVal"] as! NSNumber
        eurValue = dictionary["eurVal"] as! NSNumber
        gbpValue = dictionary["gbpVal"] as! NSNumber
        inrValue = dictionary["inrVal"] as! NSNumber
    
    }

}
