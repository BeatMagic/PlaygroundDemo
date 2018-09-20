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
        
        self.initAllTimbre()
    }
    
    static func getSampler(timbre: MusicKeyAttributesModel.KeyToneAggregate) ->AKMIDISampler{
        
        return self.soundEngine.GetSampler(timbre: timbre.rawValue)
    }
    
    /// 初始化所有音色
    private func initAllTimbre() -> Void {
        
        for index in 0 ..< MusicAttributesModel.toneWithFileArray.count {
            let sampler: AKMIDISampler = {
                let tmpSampler = AKMIDISampler()
                
                // TODO: BUG
//                let audioFileArray = self.getAKAudioFileArrayFrom(index)
//
//                try! tmpSampler.loadAudioFiles(audioFileArray)
                
                try! tmpSampler.loadMelodicSoundFont("GeneralUserPiano", preset: 0)
                return tmpSampler
            }()
            
            TimbreManager.soundEngine.RegistTimbre(timbre: index, sampler: sampler)
        }
        
    }// funcEnd
    
}

extension TimbreManager {
    /// 通过toneWithFileArray的Index 返回一个AKAudioFile数组
    func getAKAudioFileArrayFrom(_ arrayIndex: Int) -> [AKAudioFile] {
        let fileNameArray = MusicAttributesModel.toneWithFileArray[arrayIndex]
        var audioFileArray: [AKAudioFile] = []
        
        for fileName in fileNameArray {
            audioFileArray.append(try! AKAudioFile(readFileName: fileName))
        }
        
        return audioFileArray
        
    }// funcEnd
}

