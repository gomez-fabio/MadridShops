//
//  SaveAllShopsInteractorImplementation.swift
//  MadridShops
//
//  Created by Fabio Gomez on 18/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import Foundation
import CoreData

class SaveAllShopsInteractorImplementation: SaveAllShopsInteractor {

    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void) {
        execute(shops: shops, context: context, onSuccess: onSuccess, onError: nil)
    }
    
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        
        for i in 0 ..< shops.count() {
            
            let shop   = shops.get(index: i)
            let shopCD = ShopCD(context: context)
           
            // Mapping shop into shopCD
            shopCD.name           = shop.name
            shopCD.address        = shop.address
            shopCD.image          = shop.image
            shopCD.logo           = shop.logo
            /*
            shopCD.latitude       = shop.latitude!
            shopCD.longitude      = shop.latitude!
             */
            shopCD.description_en = shop.description
            shopCD.openingHours   = shop.openingHours
        }
        do {
            try context.save()
            onSuccess(shops)
        } catch {
            
        }
        
    }
}
