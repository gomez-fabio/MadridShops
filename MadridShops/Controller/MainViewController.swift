//
//  MainViewController.swift
//  MadridShops
//
//  Created by Fabio Gomez on 11/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import UIKit
import FillableLoaders
import CoreData

class MainViewController: UIViewController {
    
    var context: NSManagedObjectContext! // Propiedad que me creo para que me inyecten el contexto y a su vez yo lo paso al siguiente VC
    
    @IBOutlet weak var redRectangle: UIView!
    
    var myLoader: WavesLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //// Star Drawing
        let starPath = UIBezierPath()
        starPath.move(to:    CGPoint(x: 180,    y: 25))
        starPath.addLine(to: CGPoint(x: 195.16, y:  43.53))
        starPath.addLine(to: CGPoint(x: 220.9,  y: 49.88))
        starPath.addLine(to: CGPoint(x: 204.54, y: 67.67))
        starPath.addLine(to: CGPoint(x: 205.27, y: 90.12))
        starPath.addLine(to: CGPoint(x: 180,    y: 82.6))
        starPath.addLine(to: CGPoint(x: 154.73, y: 90.12))
        starPath.addLine(to: CGPoint(x: 155.46, y: 67.67))
        starPath.addLine(to: CGPoint(x: 139.1,  y: 49.88))
        starPath.addLine(to: CGPoint(x: 164.84, y: 43.53))
        starPath.close()
        
        //UIColor.gray.setFill()
        //starPath.fill()
        
        let myPath = starPath.cgPath
        self.myLoader = WavesLoader.showLoader(with: myPath)
        self.view.addSubview(self.myLoader!)
        
        let rect = CGRect(x: 10, y: 100, width: 200, height: 200)
        let v = UIView(frame: rect)
        v.backgroundColor = UIColor.blue
        self.view.addSubview(v)
        
        // gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateView) )
        tapGesture.numberOfTouchesRequired = 1 // nº de dedos
        tapGesture.numberOfTapsRequired    = 2 // veces que los dedos golpean la pantalla
        self.view.addGestureRecognizer(tapGesture)
        
        // swipe gesture recognizer
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(restoreView))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
    }

    @objc func animateView() {
        UIView.animate(withDuration: 2.0) {
            if let v = self.myLoader {
                let newFrame = CGRect(x: v.frame.origin.x, y: v.frame.origin.y + 200, width: v.frame.size.width, height: v.frame.size.height)
                v.frame = newFrame
            }
            self.redRectangle.layer.cornerRadius = 20
            self.redRectangle.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }
    }

    @objc func restoreView() {
        UIView.animate(withDuration: 0.5, animations: {
            if let v = self.myLoader {
                let newFrame = CGRect(x: 0, y: 0, width: v.frame.size.width, height: v.frame.size.height)
                v.frame = newFrame
            }
        }) { (stop: Bool) in
            UIView.animate(withDuration: 1.0, animations: {
                self.redRectangle.layer.cornerRadius = 0
                self.redRectangle.backgroundColor = UIColor.red
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopsSegue" {
            let vc = segue.destination as! ViewController
            vc.context = self.context
        }
    }
}
