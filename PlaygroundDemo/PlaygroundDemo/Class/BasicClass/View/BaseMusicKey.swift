//
//  BaseMusicKey.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/15.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class BaseMusicKey: UIView {
    /// 主键
    let mainKey: Int!
    
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
            print("\(self.mainKey!)号按钮\(pressStatus)")
        }
    }
    
    
    /// 拖动的最后位置
    var lastLocation = CGPoint(x: 0, y: 0)
    
    
    init(frame: CGRect,
         mainKey: Int,
         borderColor: UIColor,
         toneKey: MusicKeyAttributesModel.KeyToneAggregate,
         pitch: UInt8,
         kind: MusicKeyAttributesModel.KeyKinds) {
        
        self.mainKey = mainKey
        self.borderColor = borderColor
        self.kind = kind
        self.toneKey = toneKey
        self.pitch = pitch
        
        super.init(frame: frame)
        
        self.setData()
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}

// MARK: - 设置自身属性
extension BaseMusicKey {
    /// 设置UI
    func setUI() -> Void {
        self.backgroundColor = UIColor.black
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = FrameStandard.KeyBorderWidthAggregate.normal.rawValue
        self.layer.cornerRadius = FrameStandard.KeyBorderWidthAggregate.normal.rawValue * 4
        
    }// funcEnd
    
    /// 设置数据
     @objc func setData() -> Void {
        let name = Notification.Name(rawValue: EventQueueManager.MsgName)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.makeNoise),
                                               name: name,
                                               object: nil)


    }// funcEnd
    
    /// [通知]发出声音
    @objc func makeNoise() -> Void {
        
    }
}
