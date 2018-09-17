//
//  SoundEngine.swift
//  PlaygroundDemo
//
//  Created by apple on 2018/9/15.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit
import AudioKit

class SoundEngine: NSObject {
    
    var mixer  = AKMixer()
    var timbreDict = [Int:AKMIDISampler]()
    
    
    override init(){
        
        
        AudioKit.output = mixer
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
        
        super.init()
    }
    
    func GetSampler(timbre:Int) -> AKMIDISampler{
  
        let returnValue = self.timbreDict[timbre]
        return returnValue!
    }
    
    func RegistTimbre(timbre:Int,sampler: AKMIDISampler){
        self.timbreDict.updateValue(sampler, forKey: timbre)
        mixer.connect(input: sampler)
    }
    
    
    
}
