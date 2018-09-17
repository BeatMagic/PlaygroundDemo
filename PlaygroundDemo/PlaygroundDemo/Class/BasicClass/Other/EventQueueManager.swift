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
    
    static var count:Int = 0
    static var lastCountTime : Double = 0.0
    //字典 key是groupid value是一个队列
    static var groupQueueDict = [Int:EventQueue]()
    
    static func AddEvent(groupId:Int, event:KeyTouchEvent){
        
        
    }
    
    static func postBeatMessage() -> Void {
        let name = NSNotification.Name(rawValue: EventQueueManager.MsgName)
        NotificationCenter.default.post(name: name, object: nil)
    }
}


extension EventQueueManager: BeatTimerDelegate{
     func doThingsWhenTiming(){
        
        EventQueueManager.count += 1
        EventQueueManager.lastCountTime = Date().timeIntervalSince1970
        
    }
}
