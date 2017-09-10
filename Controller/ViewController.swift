//
//  ViewController.swift
//  MadridShops
//
//  Created by Fabio Gomez on 9/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shops : Shops? // Lo pongo como opcional para no tener init
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let downloadShopInteractor : DownloadAllShopsInteractor = DownloadAllShopsInteractorFakeImplementation()
        
//        downloadShopInteractor.execute(onSuccess: { (shops: Shops) in
//                // todo OK
//        }) { (error: Error) in
//                // error
//        }
//
//        downloadShopInteractor.execute(onSuccess: { (shops: Shops) in
//            // todo OK
//        })
        
        downloadShopInteractor.execute { (shops: Shops) in
            // todo OK
            print("Name " + shops.get(index: 0).name)
            self.shops = shops
            
            // Añado el delegado y el datasource aquí, porque aqui es cuando ya tengo creadas todas las tiendas por el interactor.
            self.shopsCollectionView.delegate   = self
            self.shopsCollectionView.dataSource = self
        }
    }


}

