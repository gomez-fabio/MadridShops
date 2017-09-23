//
//  ViewController+CollectionViewController.swift
//  MadridShops
//
//  Created by Fabio Gomez on 10/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import UIKit

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // shops está declarado como opcional en el ViewController
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCell
        
        let ShopCD: ShopCD = fetchedResultsController.object(at: indexPath)
        
        cell.refresh(shop: mapShopCDIntoShop(shopCD: ShopCD) )
        
        return cell
    }
    
    
}
