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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.shop?.name
        self.shopDetailDescription.text = self.shop?.description
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.shop?.image.loadImage2(into: shopImage)
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }

   
}
