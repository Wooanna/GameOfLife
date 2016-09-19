//
//  InfiniteView.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/19/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import UIKit

class InfiniteView: UIScrollView, UIScrollViewDelegate {

    var boardView : BoardView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        boardView = BoardView(frame: CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width: self.frame.size.width * 3, height: self.frame.size.height)))
        self.insertSubview(boardView, at: 0)
        self.minimumZoomScale = 0.5
        self.maximumZoomScale = 2
        self.zoomScale = 1.0
        contentSize = CGSize(width: frame.size.width * 3, height: frame.size.height * 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if(scrollView.contentOffset.x >= (boardView.frame.size.width / 3) * 2) {
            scrollView.scrollRectToVisible(CGRect(x:0, y: 0, width: frame.size.width, height: frame.size.height), animated: false)
            boardView.contentOffsetX = boardView.contentOffsetX + Int(boardView.frame.size.width)
        } else if(scrollView.contentOffset.x <= 0) {
            scrollView.scrollRectToVisible(CGRect(x: frame.size.width * 2, y: 0, width: frame.size.width, height: frame.size.height), animated: false)
            boardView.contentOffsetX =  boardView.contentOffsetX - Int(boardView.frame.size.width)
        }
        
        if(scrollView.contentOffset.y >= (boardView.frame.size.height / 3) * 2) {
            scrollView.scrollRectToVisible(CGRect(x:0, y: 0, width: frame.size.width, height: frame.size.height), animated: false)
            boardView.contentOffsetY = boardView.contentOffsetY + Int(boardView.frame.size.height)
        } else if(scrollView.contentOffset.y <= 0) {
            scrollView.scrollRectToVisible(CGRect(x: 0, y: frame.size.height * 2, width: frame.size.width, height: frame.size.height), animated: false)
            boardView.contentOffsetY =  boardView.contentOffsetY - Int(boardView.frame.size.height)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }
}