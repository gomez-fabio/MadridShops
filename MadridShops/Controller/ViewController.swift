//
//  ViewController.swift
//  MadridShops
//
//  Created by Fabio Gomez on 9/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var context : NSManagedObjectContext!
    var shops : Shops? // Lo pongo como opcional para no tener init
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let downloadShopInteractor : DownloadAllShopsInteractor = DownloadAllShopsInteractorFakeImplementation() // Implementación Fake
//        let downloadShopInteractor : DownloadAllShopsInteractor = DownloadAllShopsInteractorNSOperationImplementation() // Implementación con NSOperationQueue
        let downloadShopInteractor : DownloadAllShopsInteractor = DownloadAllShopsinteractorNSURLSessionImplementation() // Implementación con NSURLSession

        downloadShopInteractor.execute { (shops: Shops) in
            // todo OK
            print("Name " + shops.get(index: 0).name)
            self.shops = shops
            
            // Añado el delegado y el datasource aquí, porque aqui es cuando ya tengo creadas todas las tiendas por el interactor.
            self.shopsCollectionView.delegate   = self
            self.shopsCollectionView.dataSource = self
            
            let cacheInteractor = SaveAllShopsInteractorImplementation()
            
            // Una vez descargadas las tiendas, las puedo usar en el interactor que las guarda.
            cacheInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops: Shops) in
    
            })
        }
    }

    // Método para lanzar el segue manualmente
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let shop = self.shops?.get(index: indexPath.row)
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
    }
    
    // Método que invoca el storyboard justo antes de mostrar el view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Compruebo desde que segue vengo con su identificador
        if segue.identifier == "ShowShopDetailSegue" {
            // Cast a nuestra clase para que no sea un view controller generico, y así tenga las propiedades y métodos de nuestra clase
            let vc = segue.destination as! ShopDetailViewController
            
//            let indexPath = self.shopsCollectionView.indexPathsForSelectedItems![0] // Array de index path del collection view donde hemos tocado, cogemos el primer elemento.
//            let shop      = self.shops?.get(index: indexPath.row) // Extraigo la tienda segun su index path
//            vc.shop       = shop // esto es una inyección de dependencias de una propiedad
            vc.shop = (sender as! Shop)
        }
    }

}

