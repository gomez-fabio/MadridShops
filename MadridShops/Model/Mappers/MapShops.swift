//
//  MapShops.swift
//  MadridShops
//
//  Created by Fabio Gomez on 18/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import Foundation
import CoreData

func mapShopCDIntoShop(shopCD: ShopCD) -> Shop {
 
    // Mapping shopCD into shop
    let shop = Shop(name: shopCD.name!)
    shop.name         = shopCD.name ?? ""
    shop.address      = shopCD.address  ?? ""
    shop.image        = shopCD.image  ?? ""
    shop.logo         = shopCD.logo  ?? ""
    shop.latitude     = shopCD.latitude
    shop.longitude    = shopCD.latitude
    shop.description  = shopCD.description_en ?? ""
    shop.openingHours = shopCD.openingHours  ?? ""
    
    return shop
}

func mapShopIntoShopCD(context: NSManagedObjectContext,shop: Shop) -> ShopCD {
  
    // Mapping shop into shopCD
    let shopCD = ShopCD(context: context)
    shopCD.name           = shop.name
    shopCD.address        = shop.address
    shopCD.image          = shop.image
    shopCD.logo           = shop.logo
    shopCD.latitude       = shop.latitude ?? 0.0
    shopCD.longitude      = shop.latitude ?? 0.0
    shopCD.description_en = shop.description
    shopCD.openingHours   = shop.openingHours
    
    return shopCD
}
