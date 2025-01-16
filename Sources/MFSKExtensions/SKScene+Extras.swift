//   /\/\__/\/\      MFSKExtensions
//   \/\/..\/\/      Extensions for SpriteKit
//      (oo)
//  MooseFactory
//    Software       ©2024 - Tristan Leblanc
//  --------------------------------------------------
//  SKScene+Extras.swift
//  Created by Tristan Leblanc on 28/12/2024.

import SpriteKit

public extension SKScene {
    
    func label(_ name: String) -> SKLabelNode? {
        childNode(withName: name) as? SKLabelNode
    }
    
    func button(_ name: String) -> ButtonNode? {
        childNode(withName: name) as? ButtonNode
    }
    
}
