//
//  ShopDetailViewController.swift
//  MadridShops
//
//  Created by Fabio Gomez on 16/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import UIKit

class ShopDetailViewController: UIViewController {
    
    // Lo pongo como opcional para no tener que poner init, también lo puedo poner con un force unwrap var shop: Shop!
    var shop: Shop?
    
    @IBOutlet weak var shopDetailDescription: UITextView!
    @IBOutlet weak var shopImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.shop?.name
        self.shopDetailDescription.text = self.shop?.description
        self.shop?.image.loadImage(into: shopImage)

    }

   
}
