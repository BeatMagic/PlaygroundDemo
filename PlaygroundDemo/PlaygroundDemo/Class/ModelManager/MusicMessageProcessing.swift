//
//  MusicMessageProcessing.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/20.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class MusicMessageProcessing: NSObject {
    /// 给定一个音阶与八度信息 返回音高midi音符数字
    static func getMidiNote(_ scaleName: String, octaveCount: Int, isRising: Bool?) -> UInt8 {
        var tmpScale: UInt8 = 0
        let tmpOctaveCount = UInt8(octaveCount)
        
        
        switch scaleName {
        case "A":
            tmpScale = 9
            
        case "B":
            tmpScale = 11
            
        case "C":
            tmpScale = 0
            
        case "D":
            tmpScale = 2
            
        case "E":
            tmpScale = 4
            
        case "F":
            tmpScale = 5
            
        case "G":
            tmpScale = 7
            
        default:
            return 0
        }
        
        if isRising != true {
            return tmpScale + tmpOctaveCount * 12 + 24
            
        }else {
            return tmpScale + tmpOctaveCount * 12 + 1 + 24
            
        }
        
    }// funcEnd
    
    /// 扩展: 通过一个字符串获取midi音符数字
    static func getMidiNoteFromString(_ noteString: String) -> UInt8 {
        let scale = ToolClass.cutStringWithPlaces(
            noteString, startPlace: 0, endPlace: 1
        )
        
        let octaveCountString = ToolClass.cutStringWithPlaces(
            noteString, startPlace: noteString.count - 1, endPlace: noteString.count
        )
        
        let isRising: Bool = {
            if noteString.range(of: "#") == nil {
                return false
                
            }
            
            return true
            
        }()
        
        return self.getMidiNote(scale, octaveCount: Int(octaveCountString)!, isRising: isRising)
        
    }
}
