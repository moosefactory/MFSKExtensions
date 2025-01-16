//   /\/\__/\/\      MFSKExtensions
//   \/\/..\/\/      Extensions for SpriteKit
//      (oo)
//  MooseFactory
//    Software       ©2024 - Tristan Leblanc
//  --------------------------------------------------
//  Panel.swift
//  Created by Tristan Leblanc on 14/12/2024.

import SpriteKit

#if os(macOS)
import Cocoa

open class Panel: SKNode {
    
    var displays: [Display] = []
    var font: NSFont = NSFont(name: "Arial Bold", size: 28) ?? NSFont.systemFont(ofSize: 28)
    var titleFont: NSFont = NSFont(name: "Arial", size: 22) ?? NSFont.systemFont(ofSize: 22)
    
    public lazy var box: SKShapeNode = {
        
        var rect = calculateAccumulatedFrame().insetBy(dx: -10, dy: -10)
        rect.origin = CGPoint(x: -rect.width / 2, y: -rect.height / 2)
        let box = SKShapeNode(rect: rect, cornerRadius: 10)
        addChild(box)
        return box
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        box.fillColor = .black.withAlphaComponent(0.4)
    }
    
}

#else

import UIKit

open class Panel: SKNode {
    
    var displays: [Display] = []
    var font: UIFont = UIFont(name: "Arial Bold", size: 28) ?? UIFont.systemFont(ofSize: 28)
    var titleFont: UIFont = UIFont(name: "Arial", size: 22) ?? UIFont.systemFont(ofSize: 22)
    
    
    public lazy var box: SKShapeNode = {
        var rect: CGRect
        if let sprite = self as? SKSpriteNode {
            rect = sprite.bounds
        } else {
            rect = calculateAccumulatedFrame().insetBy(dx: -10, dy: -10)
        }
        rect.origin = CGPoint(x: -rect.width / 2, y: -rect.height / 2)
        let box = SKShapeNode(rect: rect, cornerRadius: 10)
        insertChild(box, at: 0)
        return box
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        box.fillColor = .black.withAlphaComponent(0.4)
    }

}

#endif
