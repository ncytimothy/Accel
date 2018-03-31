//
//  ViewController.swift
//  Accel
//
//  Created by Timothy Ng on 3/29/18.
//  Copyright © 2018 Timothy Ng. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation
import AVKit

class ViewController: UIViewController {

    var motionManager = CMMotionManager()
    let avPlayerVC = AVPlayerViewController()
    var avPlayer: AVPlayer?
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.image = UIImage(named: "Tomato")
        let urlPathString = Bundle.main.path(forResource: "IMG_2917", ofType: "m4v")
        if let urlPath = urlPathString {
            let movieURL = URL(fileURLWithPath: urlPath)
            self.avPlayer = AVPlayer(url: movieURL)
            self.avPlayerVC.player = avPlayer
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayerVC.player?.currentItem)
            let playerLayer = AVPlayerLayer(player: avPlayer)
            playerLayer.frame = self.view.frame
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func pressPlay(_ sender: Any) {
//        present(avPlayerVC, animated: true, completion: {
//            self.avPlayerVC.player?.play()
//        })
    

    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.avPlayerVC.player?.seek(to: kCMTimeZero)
        self.avPlayerVC.dismiss(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        motionManager.accelerometerUpdateInterval = 1.0
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { data, error in
            if let myData = data {
                print("\(myData)")
                if myData.acceleration.x >= 3.5 || myData.acceleration.x <= -3.5  {
                    print("I LOVE VERONICA!")
                    let videoVC = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as! VideoViewController
                    self.present(videoVC, animated: true, completion: nil)
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}


