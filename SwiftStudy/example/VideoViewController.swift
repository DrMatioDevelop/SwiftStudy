//
//  VideoViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/28.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class VideoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let videoIdentifier = "videoIdentifier"
    let videoTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height), style: UITableViewStyle.plain)
    var playViewController : AVPlayerViewController?
    var playView : AVPlayer?
    let videoDS = [
        VideoModel(imgStr: "videoScreenshot01", title: "Introduce 3DS Mario", Source: "Youtube - 06:32"),
        VideoModel(imgStr: "videoScreenshot02", title: "Emoji Among Us", Source: "Vimeo - 3:34"),
        VideoModel(imgStr: "videoScreenshot03", title: "Seals Documentary", Source: "Vine - 00:06"),
        VideoModel(imgStr: "videoScreenshot04", title: "Adventure Time", Source: "Youtube - 02:39"),
        VideoModel(imgStr: "videoScreenshot05", title: "Facebook HQ", Source: "Facebook - 10:20"),
        VideoModel(imgStr: "videoScreenshot06", title: "Lijiang Lugu Lake", Source: "Allen - 20:30")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableView.delegate   = self
        videoTableView.dataSource = self
        videoTableView.register(VideoTableViewCell.self, forCellReuseIdentifier: videoIdentifier)
        view.addSubview(videoTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playView = nil
        playViewController = nil
    }
    
    
    /// 是否隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return false
    }

    func playVideo() {
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        if path == nil {
            print("没有该文件！")
            return
        }
        
        playView = AVPlayer(url: URL(fileURLWithPath: path!))
        playViewController = AVPlayerViewController()
        playViewController?.player = playView
        self.present(playViewController!, animated: true) { 
            self.playView?.play()
        }
    }
    
    //MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoDS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: videoIdentifier) as! VideoTableViewCell
        cell.setModel(model: videoDS[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return KISSize.height / 3.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playVideo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


