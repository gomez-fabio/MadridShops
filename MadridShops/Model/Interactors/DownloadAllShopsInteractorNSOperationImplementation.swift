//
//  DownloadAllShopsInteractorNSOperationImplementation.swift
//  MadridShops
//
//  Created by Fabio Gomez on 11/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorNSOperationImplementation : DownloadAllShopsInteractor {
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)     // Llamamos al otro método pasándole nil en la clausura de error
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure = nil) {
        
        let urlSring = "https://madrid-shops.com/json_new/getShops.php"
        
        // Me creo una cola
        let queue = OperationQueue()
        
        // Y le añado una operación
        queue.addOperation {
            if let url = URL(string: urlSring), let data = NSData(contentsOf: url) as Data? {
                do {
                    // Serializo los datos que nos bajamos de internet, lo meto en un objeto y hago un casting para convertirlo en un diccionario
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                    // el nodo raiz del json es el elemento del diccionario que tiene como clave result
                    let result = jsonObject["result"] as! [Dictionary<String, Any>] // Fuerzo un cast a array de Diccionario (cada uno de los elementos del Json)
                    
                    let shops = Shops()
                    for shopJson in result {
                        let shop = Shop(name: shopJson["name"]! as! String)
                        shop.address = shopJson["address"]! as! String
                        
                        shops.add(shop: shop)
                    }
                    
                    OperationQueue.main.addOperation {
                        onSuccess(shops)
                    }
                    
                } catch {
                    
                }
                
            }
        }
    }
    
}

    

