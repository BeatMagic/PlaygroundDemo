//
//  ViewController.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/14.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var keysView: OperateKeysView!
    
    var timbreMgr: TimbreManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setData()
        self.setUI()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData() -> Void {
        self.timbreMgr = TimbreManager()
        BeatTimer.delegate = self
        MusicAttributesModel.BeatsCountInOneMinute = 90
    }
    
    func setUI() -> Void {
        self.view.backgroundColor = UIColor.black
        self.keysView = OperateKeysView.init(frame: CGRect.init(
            x: 0,
            y: 0,
            width: ToolClass.getScreenWidth(),
            height: ToolClass.getScreenHeight()))
        
        self.view.addSubview(self.keysView)
        
    }

}

extension ViewController: BeatTimerDelegate {
    func doThingsWhenTiming() {
        EventQueueManager.doEveryBeat()
        
//        print(BeatTimer.getCurrentBeatTime())
    }
    
}

