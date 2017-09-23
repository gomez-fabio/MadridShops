//
//  SetExecutedOnceInteractorImplementation.swift
//  MadridShops
//
//  Created by Fabio Gomez on 18/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import Foundation

class SetExecutedOnceInteractorImplementation : SetExecutedOnceInteractor {
    func execute() {
        let defaults = UserDefaults.standard
        
        defaults.set("Fabio was here!", forKey: "once")
        
        defaults.synchronize()
    }
    
    
}
