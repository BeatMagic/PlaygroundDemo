//
//  MusicKeyAttributesModel.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/17.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class MusicKeyAttributesModel: NSObject {
    /// 按钮音色枚举
    enum KeyToneAggregate: Int {
        case clap = 0, hh, kickHh, pad, pluck, shake, snare
        
    }
    
    /// 按钮状态(按下 / 抬起 ...)
    enum KeyStatus: Int {
        case Pressed = 0
        case Unpressed = 1
    }
    
    /// 按钮种类Key
    enum KeyKinds: Int {
        /// 普通
        case Normal = 0
        
        /// 边框可变
        case BorderVariable = 1
        
        /// 可拖动
        case Movable = 2
    }
    
    // MARK: - 静态数据
    /// 按键之间重叠字典Dict (下层KeyIndex: [上层keyIndex])
    static let StackKeysDict :[Int: [Int]] = [
        0: [2, 3],
        8: [9],
        ]
    
}

class ToneItemModel: NSObject {
    /// 音色文件名
    let toneFileName: String!
    
    /// 音高
    let pitch: UInt8!
    
    init(toneFileName: String) {
        self.toneFileName = toneFileName
        self.pitch = MusicMessageProcessing.getMidiNoteFromFileName(toneFileName)
        
        super.init()
    }
    
}

class MusicKeyViewModel: NSObject {
    /// 自身frame
    var ownFrame: CGRect!
    
    /// 种类
    let ownKind: MusicKeyAttributesModel.KeyKinds!

    init(_ ownFrame: CGRect,
         _ ownKind: MusicKeyAttributesModel.KeyKinds) {
        
        self.ownFrame = ownFrame
        self.ownKind = ownKind
        
        super.init()
    }
}
