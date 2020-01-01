//
//  ViewController.swift
//  Buxury
//
//  Created by Chunyou Su on 11/7/19.
//  Copyright © 2019 The Window Specialist. All rights reserved.
//

import UIKit
//import AVKit

class ViewController: UIViewController {
    
//    var videoPlayer:AVPlayer?
//    var videoPlayerLayer:AVPlayerLayer?

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
        
    }
    
    func setUpVideo() {
        //get path to the resource
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        
        //create a url from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        //Create video player item
        //let item = AVPlayerItem(url: url)
        
        //create player
        //videoPlayer = AVPlayer(playerItem: item)
        
        //create layer
        //videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //adjust size frame
        //videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*0.7, y:0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        //view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        //add to the view and play
        //videoPlayer?.playImmediately(atRate: 0.4)
    
    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }


}

