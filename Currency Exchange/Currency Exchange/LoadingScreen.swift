//
//  LoadingScreen.swift
//  Currency Exchange
//
//  Created by Devanshu on 22/07/18.
//  Copyright © 2018 Devanshu. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class LoadingScreen: UIViewController, AVAudioPlayerDelegate {
    
    // Outlets and Variables
    
    @IBOutlet var loadingimages: UIImageView?
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        
        let tabbarvc = self.storyboard!.instantiateViewController(withIdentifier: "tabbarvc")
        
        super.viewDidLoad()
        
        // Animation Images array
        
        loadingimages!.animationImages = [
            
            UIImage(named: "01.png")!,
            UIImage(named: "02.png")!,
            UIImage(named: "03.png")!,
            UIImage(named: "04.png")!,
            UIImage(named: "05.png")!,
            UIImage(named: "06.png")!,
            UIImage(named: "07.png")!,
            UIImage(named: "08.png")!,
            UIImage(named: "09.png")!,
            UIImage(named: "10.png")!,
            UIImage(named: "11.png")!,
            UIImage(named: "12.png")!,
            UIImage(named: "13.png")!,
            UIImage(named: "14.png")!,
            UIImage(named: "15.png")!,
            UIImage(named: "16.png")!,
            UIImage(named: "17.png")!,
            UIImage(named: "18.png")!,
            UIImage(named: "19.png")!,
            UIImage(named: "20.png")!,
            UIImage(named: "21.png")!,
            UIImage(named: "22.png")!,
            UIImage(named: "23.png")!,
            UIImage(named: "24.png")!,
            UIImage(named: "25.png")!,
            UIImage(named: "26.png")!,
            
        ]
        
        loadingimages?.animationRepeatCount = 1
        
        loadingimages?.animationDuration = 2.5
        
        loadingimages?.startAnimating()
        
        let delay = 2.5 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            self.loadingsound()
            
            self.present(tabbarvc, animated: true, completion: nil)
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let tabbarvc = self.storyboard!.instantiateViewController(withIdentifier: "tabbarvc")
        
        super.viewDidAppear(animated)
        
        let delay = 2.8 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            self.present(tabbarvc, animated: true, completion: nil)
            
        }
        
    }
    
    func loadingsound() {
        
        if let soundURL = Bundle.main.url(forResource: "Tap Sound", withExtension: "wav") {
            
            var mySound: SystemSoundID = 0
            
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            
            AudioServicesPlaySystemSound(mySound);
            
        }
        
    }
    
}
