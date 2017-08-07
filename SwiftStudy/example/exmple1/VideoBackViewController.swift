//
//  VideoBackViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/2.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class VideoBackViewController: BaseViewController, AVPlayerViewControllerDelegate {
    
    let playerVC = AVPlayerViewController()
    let loginBtn = UIButton(frame: CGRect(x: 30, y: KISSize.height - 150, width: KISSize.width - 60, height: 50.0))
    let regisBtn = UIButton(frame: CGRect(x: 30, y: KISSize.height - 70, width: KISSize.width - 60 , height: 50.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        setMOviePlayer()
    }

    func setMOviePlayer () {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments.mp4", ofType: nil)!)
        playerVC.player = AVPlayer(url: url)
        playerVC.showsPlaybackControls = false
        playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill //视频画面适应方式  全屏
        playerVC.view.frame = CGRect(x: 0, y: KINavAndStateBarH, width: KISSize.width, height: KISSize.height - KINavAndStateBarH)
        playerVC.view.alpha = 0
        
        //监听视频播放完成状态
        NotificationCenter.default.addObserver(self, selector: #selector(repeatPlay), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerVC.player?.currentItem)
        view.addSubview(playerVC.view)
        view.sendSubview(toBack: playerVC.view)
        
        UIView.animate(withDuration: 1) { 
            self.playerVC.view.alpha = 1
            self.playerVC.player?.play()
        }
    }
    
    func repeatPlay () {
        playerVC.player?.seek(to: kCMTimeZero)
        playerVC.player?.play()
    }
    
    func setUpView () {
        loginBtn.setTitle("登陆", for: UIControlState.normal)
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.cornerRadius = 5.0
        loginBtn.addTarget(self, action: #selector(ckiclLogin(btn:)), for: UIControlEvents.touchUpInside)
        
        regisBtn.setTitle("注册", for: UIControlState.normal)
        regisBtn.layer.borderColor = UIColor.white.cgColor
        regisBtn.layer.borderWidth = 1.0
        regisBtn.layer.cornerRadius = 5.0
        regisBtn.addTarget(self, action: #selector(clickRegisBtn(btn:)), for: UIControlEvents.touchUpInside)
        
        view.addSubview(loginBtn)
        view.addSubview(regisBtn)
    }
    
    //MARK: - Click
    func ckiclLogin (btn : UIButton) {
        print(btn.currentTitle!)
    }
    
    func clickRegisBtn (btn : UIButton) {
        print(btn.currentTitle!)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
