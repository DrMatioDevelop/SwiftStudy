//
//  CollectionViewCell.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/28.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    let featureImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height))
    let interestTitleLabel  = UILabel(frame: CGRect(x: 0, y: itemSize.height - 50, width: itemSize.width, height: 20))
    let interestDetailLabel = UILabel(frame: CGRect(x: 0, y: itemSize.height - 30, width: itemSize.width, height: 30))
    
    var data : UICollectionModel? {
        /*
         * 属性观察器  willSet 在新的值被设置之前调用  didSet 在新的值被设置之后立即调用
         */
        willSet {
            print("will Set")
        }
        didSet{
            upDateUI()
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        interestTitleLabel.backgroundColor = UIColor.gray
        interestTitleLabel.textColor       = UIColor.white
        interestTitleLabel.textAlignment   = NSTextAlignment.center
        if #available(iOS 8.2, *) {
            interestTitleLabel.font            = UIFont.systemFont(ofSize: 16, weight: 4)
        } else {
            // Fallback on earlier versions
        }
        
        interestDetailLabel.backgroundColor = UIColor.gray
        interestDetailLabel.textColor       = UIColor.white
        interestDetailLabel.textAlignment   = NSTextAlignment.center
        interestDetailLabel.numberOfLines   = 0
        
        self.addSubview(featureImageView)
        self.addSubview(interestTitleLabel)
        self.addSubview(interestDetailLabel)
        
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func upDateUI() {
        featureImageView.image = data?.featuredImage
        interestTitleLabel.text = data?.title
        interestDetailLabel.text = data?.descriptions
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5.0
        featureImageView.clipsToBounds = true
    }

}
