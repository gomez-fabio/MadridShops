//
//  DownloadAllShopsinteractorNSURLSessionImplementation.swift
//  MadridShops
//
//  Created by Fabio Gomez on 16/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import Foundation

class  DownloadAllShopsinteractorNSURLSessionImplementation : DownloadAllShopsInteractor{

    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)    // Llamamos al otro método pasándole nil en la clausura de error
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        let urlSring = "https://madrid-shops.com/json_new/getShops.php"
        
        let session = URLSession.shared
        if let url = URL(string: urlSring) {
            let task    = session.dataTask(with: url) { (data: Data? , response: URLResponse?, error: Error?) in
                
                // Volvemos al hilo ppal
                OperationQueue.main.addOperation {
                    assert(Thread.current == Thread.main)
                    
                    if error == nil {
                        // OK
                        let shops = parseShops(data: data!)
                        onSuccess(shops)
                    } else {
                        // Error
                        if let errorTask = onError {
                            errorTask(error!)
                        }
                    }
                }

            }
            
            task.resume() // Iniciamos la tarea
        }
    }
    

    
    
}
