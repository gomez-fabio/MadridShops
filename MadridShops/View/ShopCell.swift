//
//  ShopCell.swift
//  MadridShops
//
//  Created by Fabio Gomez on 10/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import UIKit

class ShopCell: UICollectionViewCell {
    
    var shop: Shop?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func refresh(shop : Shop) {
        self.shop = shop
        
        self.label.text = shop.name
        self.shop?.logo.loadImage2(into: imageView)
        UIView.animate(withDuration: 1.0) {
            self.imageView.layer.cornerRadius = 30
        }
        
    }
}
