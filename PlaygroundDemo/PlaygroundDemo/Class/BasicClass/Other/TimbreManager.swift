//
//  TimbreManager.swift
//  PlaygroundDemo
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit
import AudioKit

class TimbreManager: NSObject {
    
    static var soundEngine = SoundEngine()
    
 
    override init(){
        super.init()
        
        
        self.initTimbre_0()
        
        
    }
    
    static func getSampler(timbre: MusicKeyAttributesModel.KeyToneAggregate) ->AKMIDISampler{
        
        return self.soundEngine.GetSampler(timbre: timbre.rawValue)
    }
    
    //每种音色自己写个初始化函数

    func initTimbre_0(){
        let painoSampler: AKMIDISampler = {
            let tmpSampler = AKMIDISampler()
            
            try! tmpSampler.loadMelodicSoundFont("GeneralUserPiano", preset: 0)
            
            return tmpSampler
        }()
        
        TimbreManager.soundEngine.RegistTimbre(timbre: MusicKeyAttributesModel.KeyToneAggregate.Piano.rawValue, sampler: painoSampler)
    }
    
    func initTimbre_3(){
        let drumSampler: AKMIDISampler = {
            let tmpSampler = AKMIDISampler()
            
            let bassDrumFile = try! AKAudioFile(readFileName: "bass_drum_C1.wav")
            let clapFile = try! AKAudioFile(readFileName: "snare_D1.wav")
            let closedHiHatFile = try! AKAudioFile(readFileName: "closed_hi_hat_F#1.wav")
            
            try! tmpSampler.loadAudioFiles([
                bassDrumFile, clapFile, closedHiHatFile
                ])
            
            return tmpSampler
        }()
        
        TimbreManager.soundEngine.RegistTimbre(timbre: MusicKeyAttributesModel.KeyToneAggregate.Drum.rawValue, sampler: drumSampler)
    }
}

