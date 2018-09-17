//
//  MusicAttributesModel.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/15.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class MusicAttributesModel: UIView {
    /// 按钮音色枚举
    enum KeyToneAggregate: String {
        case Tone1 = "Tone1"
    }
    
    /// 按钮状态(按下 / 抬起 ...)
    enum KeyStatus: Int {
        case pressed = 0
        case unpressed = 1
    }

}
