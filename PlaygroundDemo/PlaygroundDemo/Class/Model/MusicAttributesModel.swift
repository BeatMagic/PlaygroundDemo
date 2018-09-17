//
//  MusicAttributesModel.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/15.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class MusicAttributesModel: UIView {
    
    /// 一分钟的拍子数
    static var BeatsCountInOneMinute: Double = 60 {
        didSet {
            let sectionTime = BeatsCountInOneMinute / 60 * 4
            let everyBeatTime = sectionTime / 16

            BeatTimer.setBeatTimer(everyBeatTime: everyBeatTime, sectionTime: sectionTime)
        }
    }
    
    /// 标准: 一小节几个Beat
    static var StandardBeatsCountInOneSection: Double = 4 {
        didSet {
            let sectionTime = BeatsCountInOneMinute / 60 * 4
            let everyBeatTime = sectionTime / 16
            
            BeatTimer.setBeatTimer(everyBeatTime: everyBeatTime, sectionTime: sectionTime)
        }
    }
    
    /// 本地设置: 一小节几个Beat
    static var LocalBeatsCountInOneSection: Double = 16 {
        didSet {
            let sectionTime = BeatsCountInOneMinute / 60 * 4
            let everyBeatTime = sectionTime / 16
            
            BeatTimer.setBeatTimer(everyBeatTime: everyBeatTime, sectionTime: sectionTime)
        }
    }

}
