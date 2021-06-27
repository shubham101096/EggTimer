//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBOutlet weak var eggProgess: UIProgressView!
    
    
    var count = 0
    var timer : Timer?
    var count_start = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        count = eggTimes[hardness]!
        count_start = count
        eggProgess.progress = 0.0
        statusLabel.text = hardness
        
        
        if timer != nil {
            timer?.invalidate()
        }

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        
        
    }
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @objc func update() {
        if count == 0 {
            timer?.invalidate()
            statusLabel.text = "Done"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
            
            //Code should execute after 0.2 second delay.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                //Bring's sender's opacity back up to fully opaque.
                self.statusLabel.text = "How do you like your eggs?"
            }
        }
        if(count > 0) {
            print("\(count) seconds")
            count -= 1
            eggProgess.progress = Float(count_start - count)/Float(count_start)
        }
    }
    
    
    
    
    

}
