//
//  EventQueue.swift
//  PlaygroundDemo
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class EventQueueManager: NSObject {
    
    static let MsgName = "BeatMessage"
    
    var count:Int = 0
    var lastCountTime : Double = 0.0
    //字典 key是groupid value是一个队列
    static var groupQueueDict = [Int:EventQueue]()
    
    override init(){
        super.init()
    }
    
    static func AddEvent(groupId:Int, event:KeyTouchEvent){
        
        
    }
    
    func BeatMessage(){
        
        NSNotificationCenter.defaultCenter().postNotificationName(MsgName, object: nil)
    }
}


extension EventQueueManager : BeatTimerDelegate{
    func doThingsWhenTiming()
    {
        self.count += 1
        self.lastCountTime = Date().timeIntervalSince1970
        
    }
}
