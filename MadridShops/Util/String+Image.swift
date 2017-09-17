//
//  String+Image.swift
//  MadridShops
//
//  Created by Fabio Gomez on 17/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import UIKit

extension String {
    func loadImage (into imageView: UIImageView) {
        // Creo una cola
        let queue = OperationQueue()
        // Lanzo en segundo plano
        queue.addOperation {
            // Me paso a mi mismo, como estoy en una extensión de la clase String, self es un String.
            if let url   = URL(string: self),
               let data  = NSData(contentsOf: url),
               let image = UIImage(data: data as Data)  {
                // Vuelta al hilo ppal
                OperationQueue.main.addOperation {
                    imageView.image = image
                }
            }
        }
    }
}
