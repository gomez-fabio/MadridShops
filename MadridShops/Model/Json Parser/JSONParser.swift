//
//  JSONParser.swift
//  MadridShops
//
//  Created by Fabio Gomez on 16/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import Foundation

func parseShops (data: Data) -> Shops {
    
    let shops = Shops()
    do {
        // Serializo los datos que nos bajamos de internet, lo meto en un objeto y hago un casting para convertirlo en un diccionario
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        // el nodo raiz del json es el elemento del diccionario que tiene como clave result
        let result = jsonObject["result"] as! [Dictionary<String, Any>] // Fuerzo un cast a array de Diccionario (cada uno de los elementos del Json)

        for shopJson in result {
            let shop         = Shop(name: shopJson["name"]! as! String)
            shop.address     = shopJson["address"]! as! String
            shop.logo        = shopJson["logo_img"] as! String
            shop.image       = shopJson["img"] as! String
            shop.description = shopJson["description_en"] as! String
            
            shops.add(shop: shop)
        }
    } catch {
        print("Error parsing JSON")
    }
    return shops
}
