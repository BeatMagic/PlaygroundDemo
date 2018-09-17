//
//  BaseMusicKey.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/15.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class BaseMusicKey: UIView {
    /// 边框颜色
    var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }

    /// 音色唯一标识
    let toneKey: MusicAttributesModel.KeyToneAggregate!
    
    /// 音高
    var pitch: UInt8!
    
    /// 按钮状态
    var pressStatus: MusicAttributesModel.KeyStatus = .unpressed {
        didSet {
            /// 发送通知
            print("111")
        }
    }
    
    
    init(frame: CGRect,
         borderColor: UIColor,
         toneKey: MusicAttributesModel.KeyToneAggregate,
         pitch: UInt8) {
        
        self.toneKey = toneKey
        self.pitch = pitch
        self.borderColor = borderColor
        
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置UI
    func setUI() -> Void {
        self.backgroundColor = UIColor.black
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = FrameStandard.KeyBorderWidthAggregate.normal.rawValue
        self.layer.cornerRadius = FrameStandard.KeyBorderWidthAggregate.normal.rawValue * 4
        
    }// funcEnd
    
}

// MARK: - touch事件
extension BaseMusicKey {
    
//    // 点击
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let touchPoint = touch.location(in: self)
//            print("点击\(touchPoint)")
//        }
//
//    }
//
//    // 滑动
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let touchPoint = touch.location(in: self)
//            print("滑动\(touchPoint)")
//        }
//    }

}
