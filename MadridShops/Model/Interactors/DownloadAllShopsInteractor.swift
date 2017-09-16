//
//  DownloadAllShopsInteractor.swift
//  MadridShops
//
//  Created by Fabio Gomez on 10/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import Foundation

protocol DownloadAllShopsInteractor {
    // execute: downloads all shops. Return on the main thread
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
    func execute(onSuccess: @escaping (Shops) -> Void)
    
}

