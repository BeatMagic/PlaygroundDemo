//
//  BaseMovableMusicKey.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/17.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class BaseMovableMusicKey: BaseMusicKey {
    
    var ownCenter = CGPoint.zero
    
    override init(frame: CGRect, mainKey: Int, borderColor: UIColor, tomeModelArray: [ToneItemModel], kind: MusicKeyAttributesModel.KeyKinds) {
        
        super.init(frame: frame,
                   mainKey: mainKey,
                   borderColor: borderColor,
                   tomeModelArray: tomeModelArray,
                   kind: .Movable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @objc override func setUI() {
        super.setUI()
        
        self.isUserInteractionEnabled = true
    }
    
}
