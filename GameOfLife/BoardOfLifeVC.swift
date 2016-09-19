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

class BoardOfLifeVC: UIViewController{
    var state = GameState.new
    var gameBoard = BoardOfLife()
    var timer = Timer()
    var infiniteView: InfiniteView!
    var nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infiniteView = InfiniteView(frame: self.view.frame)
        self.view.insertSubview(infiniteView, at: 0)
        nc.addObserver(self, selector: #selector(BoardOfLifeVC.touched), name: NSNotification.Name(rawValue: "creatingNewCell"), object: nil)
    
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
    
    func touched(notification: Notification) {
        if (self.state == .new) {
            if let locDict = notification.userInfo {
                if let location = locDict["location"] as? CGPoint {
                    gameBoard.initializeCell(location: location)
                    infiniteView.boardView.setNeedsDisplay()
                }
                
            }
        }
    }
    
    func startGame() {
        if (self.state == .new || self.state == .paused) {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BoardOfLifeVC.update), userInfo: nil, repeats: true)
            self.state = .running
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
        infiniteView.boardView.setNeedsDisplay()
    }
    
    func update() {
        gameBoard.update()
        infiniteView.boardView.setNeedsDisplay()
    }
    
    
}
