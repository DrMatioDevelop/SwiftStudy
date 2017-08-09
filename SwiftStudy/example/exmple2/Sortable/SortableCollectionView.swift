//
//  SortableCollectionView.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

//声明协议
@objc protocol SortableCollectionViewDelegate {
    @objc optional func beginDragAndInitDragCell(collectionView: SortableCollectionView, dragCell : UIView)
    
    @objc optional func endDragAndResetDragCell(collectionView:SortableCollectionView, dragCell: UIView)
    
    @objc optional func endDragAndOperateRealCell(collection:SortableCollectionView,realCell: UICollectionViewCell, isMove:Bool)
    
    @objc optional func exchangeDataSource(fromIndex: IndexPath, toIndex: IndexPath)
}

class SortableCollectionView: UICollectionView {

    weak var sortableDelegate : SortableCollectionViewDelegate?
    
    var dragView : UIView!         //快照
    var originCell : sortableItem? //移动的cell
    var timer : Timer?             //刷新频率
    
    var fromIndex: IndexPath?
    var toIndex : IndexPath?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        let panGesture = UILongPressGestureRecognizer(target: self, action: #selector(panHandle(sender:)))
        addGestureRecognizer(panGesture)
    }
    
    
    //触发手势
    func panHandle(sender : UILongPressGestureRecognizer) {
        
        //手势在collectionview的位置
        let collectionViewPoint = sender.location(in: self)
        //手势点在父view的位置
        let viewPoint = sender.location(in: superview)
        //手势按下
        if sender.state == UIGestureRecognizerState.began {
            //获得手势点的cell
            if let index = indexPathForItem(at: collectionViewPoint), let originCell = cellForItem(at: index) {
                beginMoveitemAtIndex(index: index, cell: originCell as! sortableItem, viewCenter: viewPoint)
            }
        }
        //手势改变
        else if (sender.state == UIGestureRecognizerState.changed) {
            updateMoveItem(viewpoint: viewPoint, collectionViewPoint: collectionViewPoint)
        }
        //手势抬起
        else if (sender.state == UIGestureRecognizerState.ended) {
            endMoveItem()
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SortableCollectionView {
    func beginMoveitemAtIndex(index: IndexPath, cell: sortableItem, viewCenter : CGPoint) {
        
        fromIndex  = index
        originCell = cell
        cell.isHidden = true
        //如果遵循了NSCopying协议，并返回了副本的，可以用copy来获得view的副本
        if let copyable = originCell as? NSCopying {
            dragView = copyable.copy(with: nil) as! UIView
        }
        else {
            //该方法在模拟器里面无法获得快照  真机是可以的
            dragView = cell.snapshotView(afterScreenUpdates: false)
        }
        //将快照添加到父View
        dragView.center = viewCenter
        superview?.addSubview(dragView) //???
        //自动调整尺寸
        dragView.autoresizesSubviews = false
        
        //代理  开始拖动
        sortableDelegate?.beginDragAndInitDragCell?(collectionView: self, dragCell: dragView)
        bringSubview(toFront: dragView)
    }
    
    func updateMoveItem(viewpoint:CGPoint, collectionViewPoint:CGPoint) {
        //移动快照位置
        dragView.center = viewpoint
        //移动item位置
        moveItemToPoint(collectionViewPoint: collectionViewPoint)
        scrollAtEdge()
    }
    
    func endMoveItem() {
        //移动结束
        timer?.invalidate()
        timer = nil
        if let origin = originCell {
            UIView.animate(withDuration: 0.2, animations: {
                let rect = origin.frame
                self.sortableDelegate?.endDragAndResetDragCell?(collectionView: self, dragCell: self.dragView)
                self.dragView.frame = CGRect(x: rect.origin.x, y: rect.origin.y - self.contentOffset.y, width: rect.width, height: rect.height)
            }, completion: { (finished) in
                self.dragView.removeFromSuperview()
                origin.isHidden = false
                var isMoved = false
                
                if let toIndex = self.toIndex {
                    self.sortableDelegate?.exchangeDataSource?(fromIndex: self.fromIndex!, toIndex: toIndex)
                    isMoved = true
                }
                self.sortableDelegate?.endDragAndOperateRealCell?(collection: self, realCell: origin, isMove: isMoved)
            })
        }
    }
    
    func moveItemToPoint(collectionViewPoint: CGPoint) {
        if let index = indexPathForItem(at: collectionViewPoint) , let originCell = self.originCell {
            let cell = cellForItem(at: index)
            if cell != originCell {
                //由于改方法的原因，所以本项目的移动方式只适用于ios8以上系统
                self.performBatchUpdates({ 
                    if let fromIndex = self.indexPath(for: originCell) {
                        self.moveItem(at: fromIndex, to: index)
                    }
                }){
                    success in
                    if success {
                        self.toIndex = index
                    }
                }
            }
        }
    }
    
    func scrollAtEdge () {
        
        let pinTop = dragView.frame.origin.y
        let pinBottom = self.frame.height - (dragView.frame.origin.y + dragView.frame.height)
        var speed: CGFloat = 0
        var isTop:Bool = true
        
        if pinTop < 0  {
            speed = -pinTop
            isTop = true
        }
        else if pinBottom < 0 {
            speed = -pinBottom
            isTop = false
        }
        else {
            self.timer?.invalidate()
            self.timer = nil
            return
        }
        
        //???????
        if let originTimer = self.timer, let originSpeed = (originTimer.userInfo as? [String:AnyObject])?["speed"] as? CGFloat {
            if abs(speed - originSpeed) > 10 {
                originTimer.invalidate()
                NSLog("speed:\(speed)")
                let timer = Timer(timeInterval: 1/60.0, target: self, selector: #selector(autoScroll(timer:)), userInfo: ["top":isTop,"speed" : speed], repeats: true)
                self.timer = timer
                RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
            }
        }
    }
    
    //??????
    func autoScroll(timer: Timer) {
        if let userInfo = timer.userInfo as? [String : AnyObject] {
            if let top = userInfo["top"] as? Bool, let speed = userInfo["speed"] as? CGFloat {
                let offect = speed / 5
                let contentOffect = self.contentOffset
                
                if top {
                    self.contentOffset.y -= offect
                    self.contentOffset.y = self.contentOffset.y < 0 ? 0 : self.contentOffset.y
                }
                else {
                    self.contentOffset.y += offect
                    self.contentOffset.y = self.contentOffset.y > self.contentSize.height - self.frame.height ? self.contentSize.height - self.frame.height : self.contentOffset.y
                }
                
                let point = CGPoint(x: dragView.center.x, y: dragView.center.y + contentOffect.y)
                self.moveItemToPoint(collectionViewPoint: point)
            }
        }
    }
}


class sortableItem : UICollectionViewCell {
    
    let lab = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lab.frame = self.bounds
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 20)
        lab.textAlignment = NSTextAlignment.center
        lab.backgroundColor = UIColor.clear
        addSubview(lab)
    }
    
    func setSortable(model : Any) {
        lab.text = String(describing: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
