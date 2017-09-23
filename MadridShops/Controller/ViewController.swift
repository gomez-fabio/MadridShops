//
//  ViewController.swift
//  MadridShops
//
//  Created by Fabio Gomez on 9/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    var context : NSManagedObjectContext!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    let locationManager  = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization() // Pedir permiso al usuario, necesitamos además la clave en el plist
        self.locationManager.delegate = self // Nos hacemos delegados del CLLocationManager
        self.locationManager.startUpdatingLocation() // Le pedimos que nos actualice los cambios de posición.
        
        ExecuteOnceInteractorImplementation().execute {
            initializeData()
        }
        
        // Añado el delegado y el datasource aquí, porque aqui es cuando ya tengo creadas todas las tiendas por el interactor.
        self.shopsCollectionView.delegate   = self
        self.shopsCollectionView.dataSource = self
        
        let madridLocation = CLLocation(latitude: 40.418889, longitude: -3.69194)
        self.map.setCenter(madridLocation.coordinate, animated: true)
        
    }
    
    func initializeData(){
        
        //        let downloadShopInteractor : DownloadAllShopsInteractor = DownloadAllShopsInteractorFakeImplementation() // Implementación Fake
        //        let downloadShopInteractor : DownloadAllShopsInteractor = DownloadAllShopsInteractorNSOperationImplementation() // Implementación con NSOperationQueue
        let downloadShopInteractor : DownloadAllShopsInteractor = DownloadAllShopsinteractorNSURLSessionImplementation() // Implementación con NSURLSession
        
        downloadShopInteractor.execute { (shops: Shops) in
            // todo OK

            let cacheInteractor = SaveAllShopsInteractorImplementation()
            
            // Una vez descargadas las tiendas, las puedo usar en el interactor que las guarda.
            cacheInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops: Shops) in
                
                SetExecutedOnceInteractorImplementation().execute()
                
                // Añado el delegado y el datasource aquí, porque aqui es cuando ya tengo creadas todas las tiendas por el interactor.
                self._fetchedResultsController = nil
                self.shopsCollectionView.delegate   = self
                self.shopsCollectionView.dataSource = self
                self.shopsCollectionView.reloadData()
            })
        }
    }
    // Método para lanzar el segue manualmente
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let shop: ShopCD  = self.fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
    }
    
    // Método que invoca el storyboard justo antes de mostrar el view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Compruebo desde que segue vengo con su identificador
        if segue.identifier == "ShowShopDetailSegue" {
            // Cast a nuestra clase para que no sea un view controller generico, y así tenga las propiedades y métodos de nuestra clase
            let vc = segue.destination as! ShopDetailViewController
            
            let shopCD: ShopCD = sender as! ShopCD
            vc.shop = mapShopCDIntoShop(shopCD: shopCD)
        }
    }

    var _fetchedResultsController: NSFetchedResultsController<ShopCD>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ShopCD> {
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        // fetchRequest == SELECT * FROM EVENT ORDER BY TIMESTAMP DESC
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
        //aFetchedResultsController.delegate = self
        //_fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    // Metodo delegado de CLLocationManager, para recibir los cambios de localización
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.map.setCenter(location.coordinate, animated: true) // Centramos en la nueva localización.
    }

}

