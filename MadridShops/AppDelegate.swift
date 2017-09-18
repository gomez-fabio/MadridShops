//
//  AppDelegate.swift
//  MadridShops
//
//  Created by Fabio Gomez on 9/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var cds = CoreDataStack() // Inicializamos el Core Data Stack
    var context : NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.context = cds.createContainer(dbName: "MadridShops").viewContext // Extraemos el contexto de createContainer.
        
        // Estas tres lineas de abajo me sirven para crear un contexto que inyectarle a la cadena de vc que existen desde el rootVC hasta el que a mi me interesa inyectarle el contexto
        let nav = self.window?.rootViewController as! UINavigationController // Me creo una propiedad que identifica el rootvc casting a Navigation (lo puedo ver como root en el story board)
        let mainVC = nav.topViewController as! MainViewController // el topVC del nav anterior es el mainviewcontroller (de nuevo lo veo en el story board)
        mainVC.context = self.context  // a este vc en su propiedad context, le inyecto el contexto que he creado en el appDelegate.
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        guard let context = self.context else {return} // Hacemos un guard porque el contexto es opcional.
        self.cds.saveContext(context: context) // Grabamos al pasar al background.
    }



}

