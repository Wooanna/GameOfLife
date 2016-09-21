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

class BoardOfLifeVC: UIViewController {
    
    var generation = 0
    var timer = Timer()
    static var state = GameState.new
    var gameBoard = BoardOfLife()
    var infiniteView: InfiniteView!
    var nc = NotificationCenter.default
    @IBOutlet weak var generationLabel: UILabel!
    
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
    
    func startGame() {
        if ((BoardOfLifeVC.state == .new || BoardOfLifeVC.state == .paused) && BoardOfLife.cells.count > 0) {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BoardOfLifeVC.update), userInfo: nil, repeats: true)
            BoardOfLifeVC.state = .running
        }
    }
    
    func pauseGame() {
        if(BoardOfLifeVC.state == .running) {
            timer.invalidate()
            BoardOfLifeVC.state = .paused
        }
    }
    
    func restartGame() {
        if(BoardOfLifeVC.state == .running || BoardOfLifeVC.state == .paused) {
            timer.invalidate()
            generation = 0
            BoardOfLifeVC.state = .new
            BoardOfLife.cells.removeAll()
            infiniteView.boardView.setNeedsDisplay()
        }
    }
    
    func update() {
        gameBoard.update()
        generation = generation + 1
        generationLabel.text = "Generation: \(generation)"
        infiniteView.boardView.setNeedsDisplay()
    }
    
    func touched(notification: Notification) {
        if (BoardOfLifeVC.state == .new) {
            if let locDict = notification.userInfo {
                if let location = locDict["location"] as? CGPoint {
                    gameBoard.initializeCell(location: CGPoint(x: location.x + CGFloat(infiniteView.contentOffsetX), y: location.y + CGFloat(infiniteView.contentOffsetY)))
                    infiniteView.boardView.setNeedsDisplay()
                }
            }
        }
    }
    
    @IBAction func locate(_ sender: AnyObject) {
        infiniteView.contentOffsetY = 0
        infiniteView.contentOffsetX = 0
        infiniteView.contentOffset = CGPoint(x: 0, y: 0)
        infiniteView.boardView.setNeedsDisplay()
    }
}
