//
//  VideoTableViewCell.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/28.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

struct VideoModel {
    let imgStr : String
    let title  : String
    let Source : String
}
class VideoTableViewCell: UITableViewCell {

    let videoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height / 3.0))
    let videoTitle = UILabel(frame: CGRect(x: 0, y: KISSize.height / 3.0 - 50, width: KISSize.width, height: 30))
    let videoSource = UILabel(frame: CGRect(x: 0, y: KISSize.height / 3.0 - 20, width: KISSize.width, height: 20))
    
    /*
     Public:所有都可以访问
     Internal:自己framework访问（默认）
     Private:私有的
     如果写框架，public公开接口
     */
    private let videoPlay = UIImageView(frame: CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height / 3.0))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    func setupView () {
        videoImage.contentMode = UIViewContentMode.scaleAspectFit
        videoPlay.contentMode  = UIViewContentMode.center
        videoPlay.image        = UIImage(named: "playBtn")
        
        videoTitle.textColor   = UIColor.white
        videoTitle.font        = UIFont(name: "Zapfino", size: 24)
        videoTitle.textAlignment = NSTextAlignment.center
        
        videoSource.textColor  = UIColor.gray
        videoSource.font       = UIFont(name: "Avenir Next", size: 14)
        videoSource.textAlignment = NSTextAlignment.center
        
        self.addSubview(videoImage)
        self.addSubview(videoPlay)
        self.addSubview(videoTitle)
        self.addSubview(videoSource)
    }
    
    func setModel(model : VideoModel) {
        videoImage.image = UIImage(named: model.imgStr)
        videoTitle.text  = model.title
        videoSource.text = model.Source
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
