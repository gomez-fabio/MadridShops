//
//  DownloadAllShopsInteractorFakeImplementation.swift
//  MadridShops
//
//  Created by Fabio Gomez on 10/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorFakeImplementation : DownloadAllShopsInteractor {
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)     // Llamamos al otro método pasándole nil en la clausura de error
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure = nil) {
        let shops = Shops()
        
        for i in 0...10 {
            let shop = Shop(name: "Shop number \( i )")
            shop.address      = "Address \( i )"
            shop.logo         = #imageLiteral(resourceName: "umbrella.png")
            shop.openingHours = "10:00-14:00 17:00-20:30"
            
            shops.add(shop: shop)
        }
        
        // Encolo en main thread
        OperationQueue.main.addOperation {
            onSuccess(shops)
        }
    }
    
    
}
