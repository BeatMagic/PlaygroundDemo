//
//  MusicAttributesModel.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/15.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class MusicAttributesModel: NSObject {
    
    /// 一分钟的拍子数
    static var BeatsCountInOneMinute: Double = 60 {
        didSet {
            let sectionTime = 4/(BeatsCountInOneMinute / 60)
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
    
    /// 音色文件名字典 [[音色文件名]]
    static let toneWithFileArray: [[String]] = [
        ["clap_D2.wav"],
        ["HH_C2.wav"],
        ["Kick+HH_C1.wav"],
        ["pad_D1.wav"],
        [
            "pluck1_E1.wav",
            "pluck2_F1.wav",
            "pluck3_G1.wav",
            "pluck4_A1.wav",
            "pluck5_B1.wav"
        ],
        ["shake_E2.wav"],
        ["snare_F2.wav"],

    ]

}
