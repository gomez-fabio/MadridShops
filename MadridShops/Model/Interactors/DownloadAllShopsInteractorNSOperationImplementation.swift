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
                let shops = parseShops(data: data)
                
                OperationQueue.main.addOperation {
                    onSuccess(shops)
                }
            }
        }
    }
}

    

