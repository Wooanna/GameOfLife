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
    var size : CGSize!
    
    var contentOffsetX = 0 {
        didSet {
            contentOffsetX = Maths.roundToTens(n: Double(contentOffsetX))
            print("x \(contentOffsetX)")
        }
    }
    
    var contentOffsetY = 0 {
        didSet {
            contentOffsetY = Maths.roundToTens(n: Double(contentOffsetY))
            print("y \(contentOffsetY)")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        delegate = self
        zoomScale = 1.0
        bounces = false
        maximumZoomScale = 3
        minimumZoomScale = 0.6
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentOffset = CGPoint(x: 100, y: 100)
        size = CGSize(width: Maths.roundToTens(n: Double(frame.size.width) * 3.0),
                      height: Maths.roundToTens(n: Double(frame.size.width) * 3.0))
        boardView = BoardView(frame: CGRect(origin: CGPoint(x:0, y:0), size: size))
        insertSubview(boardView, at: 0)
        contentSize = size
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if (contentOffset.x > contentSize.width - frame.size.width - 1) {
            contentOffset = CGPoint(x: 0, y: contentOffset.y)
            contentOffsetX = contentOffsetX + Int(contentSize.width)
            boardView.setNeedsDisplay()
        } else if (contentOffset.x == 0) {
            contentOffset = CGPoint(x: contentSize.width - frame.size.width - 1, y: contentOffset.y)
            contentOffsetX = contentOffsetX - Int(contentSize.width)
            boardView.setNeedsDisplay()
        }
        
        if (contentOffset.y > contentSize.height - frame.size.height - 1) {
            contentOffset = CGPoint(x: contentOffset.x, y: 0)
            contentOffsetY = contentOffsetY + Int(contentSize.height)
            boardView.setNeedsDisplay()
        } else if (contentOffset.y == 0) {
            contentOffset = CGPoint(x: contentOffset.x , y: contentSize.height - frame.size.height - 1)
            contentOffsetY =  contentOffsetY - Int(contentSize.height)
            boardView.setNeedsDisplay()
        }
    }
   
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }
}
