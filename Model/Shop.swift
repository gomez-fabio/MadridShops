//
//  Shop.swift
//  MadridShops
//
//  Created by Fabio Gomez on 9/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import UIKit

public class Shop {
    var name         : String
    var description  : String = ""
    var latitude     : Float? = nil
    var longitude    : Float? = nil
    var image        : String = ""
    //var logo         : String = ""
    var logo         : UIImage? = nil
    var openingHours : String = ""
    var address      : String = ""
    
    public init(name: String) {
        self.name = name
    }
}
