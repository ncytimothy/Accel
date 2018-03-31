//
//  VideoViewController.swift
//  Accel
//
//  Created by Timothy Ng on 3/29/18.
//  Copyright © 2018 Timothy Ng. All rights reserved.
//

import UIKit
import AVFoundation

class VideoViewController: UIViewController {
    
    let path = Bundle.main.path(forResource: "tomato_explode", ofType: "mp4")
    var player: AVPlayer?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let urlPath = path {
            let url = URL(fileURLWithPath: urlPath)
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            
            playerLayer.frame = self.view.frame
            playerLayer.videoGravity = .resizeAspectFill
            self.view.layer.addSublayer(playerLayer)
            player.seek(to: kCMTimeZero)
            player.play()
            UIDevice.vibrate()
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.player?.seek(to: kCMTimeZero)
        self.player?.pause()
        self.dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}


