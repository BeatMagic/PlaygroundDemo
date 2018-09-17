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
    
    /// 种类
    let kind: MusicKeyAttributesModel.KeyKinds!

    /// 音色唯一标识
    let toneKey: MusicKeyAttributesModel.KeyToneAggregate!
    
    /// 音高
    var pitch: UInt8!
    
    /// 按钮状态
    var pressStatus: MusicKeyAttributesModel.KeyStatus = .Unpressed {
        didSet {
            
            
            /// 发送通知
            print("111")
        }
    }
    

    
    
    
    init(frame: CGRect,
         borderColor: UIColor,
         toneKey: MusicKeyAttributesModel.KeyToneAggregate,
         pitch: UInt8,
         kind: MusicKeyAttributesModel.KeyKinds) {
        
        self.borderColor = borderColor
        self.kind = kind
        self.toneKey = toneKey
        self.pitch = pitch
        
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}

// MARK: - touch事件
extension BaseMusicKey {
    /// 设置UI
    func setUI() -> Void {
        self.backgroundColor = UIColor.black
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = FrameStandard.KeyBorderWidthAggregate.normal.rawValue
        self.layer.cornerRadius = FrameStandard.KeyBorderWidthAggregate.normal.rawValue * 4
        
    }// funcEnd
    
    
}
