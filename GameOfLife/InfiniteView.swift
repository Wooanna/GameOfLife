//
//  InfiniteView.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/19/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import UIKit

class InfiniteView: UIScrollView, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    var boardView : BoardView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        boardView = BoardView(frame: CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width: self.frame.size.width * 3, height: self.frame.size.height * 3)))
        self.insertSubview(boardView, at: 0)
        self.minimumZoomScale = 0.5
        self.maximumZoomScale = 2
        self.zoomScale = 1.0
        self.bounces = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        contentSize = CGSize(width: frame.size.width * 3, height: frame.size.height * 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(self.contentOffset.x > self.contentSize.width - self.frame.size.width - 10.0) {
            self.contentOffset = CGPoint(x: 0, y: self.contentOffset.y)
            boardView.contentOffsetX = boardView.contentOffsetX + Int(boardView.frame.size.width)
        } else if(self.contentOffset.x < 10) {
            self.contentOffset = CGPoint(x: (boardView.frame.size.width / 3) * 2, y: self.contentOffset.y)
            boardView.contentOffsetX = boardView.contentOffsetX - Int(boardView.frame.size.width)
        }
        
        if(self.contentOffset.y > self.contentSize.height - self.frame.size.height - 10.0) {
            self.contentOffset = CGPoint(x: self.contentOffset.x, y: 0)
            boardView.contentOffsetY = boardView.contentOffsetY + Int(boardView.frame.size.height)
        } else if(self.contentOffset.y < 10) {
            self.contentOffset = CGPoint(x: self.contentOffset.x , y: (boardView.frame.size.width / 3) * 2)
            boardView.contentOffsetY =  boardView.contentOffsetY - Int(boardView.frame.size.height)
        }

    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }
}
