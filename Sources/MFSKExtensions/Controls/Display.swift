//   /\/\__/\/\      MFSKExtensions
//   \/\/..\/\/      Extensions for SpriteKit
//      (oo)
//  MooseFactory
//    Software       ©2024 - Tristan Leblanc
//  --------------------------------------------------
//  Display.swift
//  Created by Tristan Leblanc on 14/12/2024.

import SpriteKit

#if os(macOS)
import Cocoa
public typealias MFFont = NSFont
public typealias MFColor = NSColor
#else
import UIKit
public typealias MFFont = UIFont
public typealias MFColor = UIColor
#endif

public class Display: SKNode {
    
    static let fontName: String = "Arial"

    public var intValue: Int = 0 { didSet {
        value = "\(intValue)"
    }}
    
    public var value: String = "0" { didSet {
        valueLabel?.text = value
    }}
    
    var valueFont: MFFont = MFFont(name: Display.fontName, size: 64) ?? MFFont.systemFont(ofSize: 64)
    
    var titleFont: MFFont = MFFont(name: Display.fontName, size: 22) ?? MFFont.systemFont(ofSize: 22)
    
    public var titleLabel: SKLabelNode? { childNode(withName: "title") as? SKLabelNode }
    public var valueLabel: SKLabelNode? { childNode(withName: "value") as? SKLabelNode }
    
    public var titleColor: MFColor = .white
    public var valueColor: MFColor = .white

    override init() {
        super.init()
        updateFont()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //updateFont()
    }
    
    fileprivate func updateFont() {
        titleLabel?.fontName = titleFont.fontName
        valueLabel?.fontName = valueFont.fontName
        titleLabel?.fontSize = titleFont.pointSize
        valueLabel?.fontSize = valueFont.pointSize
        titleLabel?.fontColor = titleColor
        valueLabel?.fontColor = valueColor
    }
}
