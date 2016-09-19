//
//  BoardOfLiveVC.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/15/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import UIKit

enum GameState {
    case new, running, paused
}

class BoardOfLifeVC: UIViewController, UIScrollViewDelegate {
    var state = GameState.new
    var gameBoard = BoardOfLife()
    var timer = Timer()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var boardView: BoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1200, height: 900)
        scrollView.addSubview(boardView)
        scrollView.isUserInteractionEnabled = false
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        scrollView.zoomScale = 1.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func restartBtnPressed(_ sender: AnyObject) {
        restartGame()
    }
    
    @IBAction func playBtnPressed(_ sender: AnyObject) {
        startGame()
    }

    @IBAction func pauseBtnPressed(_ sender: AnyObject) {
        pauseGame()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.state == .new) {
            if let touch = touches.first {
                let location = touch.location(in: self.view)
                gameBoard.initializeCell(location: location)
                boardView.setNeedsDisplay()
            }
        }
    }
    
    func startGame() {
        if (self.state == .new || self.state == .paused) {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BoardOfLifeVC.update), userInfo: nil, repeats: true)
            self.state = .running
            scrollView.isUserInteractionEnabled = true
        }
    }
    
    func pauseGame() {
        if(self.state == .running) {
            timer.invalidate()
            self.state = .paused
        }
    }
    
    func restartGame() {
        if(self.state == .running || self.state == .paused) {
            timer.invalidate()
            self.state = .new
        }
        
        BoardOfLife.cells.removeAll()
        boardView.setNeedsDisplay()
    }
    
    func update() {
        gameBoard.update()
        boardView.setNeedsDisplay()
    }
    
    
}
