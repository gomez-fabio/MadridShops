//
//  SaveAllShopsInteractor.swift
//  MadridShops
//
//  Created by Fabio Gomez on 18/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import Foundation
import CoreData

protocol SaveAllShopsInteractor {
    // execute: saves all shops. Return on the main thread
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void)
}
