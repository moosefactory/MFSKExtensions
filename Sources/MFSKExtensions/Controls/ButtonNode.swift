//   /\/\__/\/\      MFSKExtensions
//   \/\/..\/\/      Extensions for SpriteKit
//      (oo)
//  MooseFactory
//    Software       ©2024 - Tristan Leblanc
//  --------------------------------------------------
//  Button.swift
//  Created by Tristan Leblanc on 21/12/2024.

import Foundation
import SpriteKit

public extension SKNode {
    func buttonNamed(_ name: String) -> ButtonNode {
        childNode(withName: name) as! ButtonNode
    }
}

open class ButtonNode: SKSpriteNode {
    
    @IBInspectable public var title: String? {
        set {
            label?.text = newValue
        }
        get {
            label?.text
        }
    }
    
    public var info: Any?
    
    /// 'structure' sprite
    /// The background and border of the button
    var structure: SKShapeNode?
    /// 'title' sprite
    var label: SKLabelNode? { childNode(withName: "title") as? SKLabelNode }
    /// 'icon' sprite
    var icon: SKSpriteNode? { childNode(withName: "icon") as? SKSpriteNode }
    /// 'overlay' sprite
    /// The highlight overlay
    var overlay: SKShapeNode?

    // MARK: Handlers
    
    public var action: (() -> Void)?
    public var dragAction: ((CGPoint, ButtonNode?, ButtonNode?) -> Void)?
    public var dragEndedAction: ((CGPoint, ButtonNode?, ButtonNode?) -> Void)?

    
    public var touchAction: (() -> Void)?
    
    /// Called when touched or entered
    /// Default action displays highlight overlay
    var highlightAction: ((ButtonNode) -> Void)?
    
    /// Called when released or exited
    /// Default action displays highlight overlay
    var unhighlightAction: ((ButtonNode) -> Void)?
    
    // MARK: Initialisation
    
    /// Initialisation
    public init(texture: SKTexture?, color: MFColor, size: CGSize, title: String) {
        super.init(texture: texture, color: color, size: size)
        self.title = title
        build()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        build()
    }

    /// Builds the button structure and overlay

    open func build() {
        overlay?.removeFromParent()
        structure?.removeFromParent()
        let rect = CGRect(origin: .zero, size: size)
        #if os(macOS)
        let bounds = rect.offsetBy(dx: -(size.width / 2), dy: -(size.height / 2))
        #else
        let bounds = bounds
        #endif
        let structure = SKShapeNode(rect: bounds, cornerRadius: 10)
        structure.name = "structure"
        structure.fillColor = MFColor.white.withAlphaComponent(0.1)
        structure.strokeColor = MFColor.white
        structure.lineWidth = 2
        
        insertChild(structure, at: 0)
        
        let overlay = SKShapeNode(rect: bounds, cornerRadius: 10)
        overlay.name = "overlay"
        overlay.fillColor = MFColor.white
        overlay.alpha = 0.001
        overlay.glowWidth = 1.0
        addChild(overlay)

        self.structure = structure
        self.overlay = overlay
        
        label?.text = title
    }
    
    /// Highlight the button by varying overlay alpha
    
    public func highlight(impulseLevel: CGFloat = 0) {
        impulse(impulseLevel: impulseLevel)
        highlightAction?(self)
    }
    
    /// Unhighlight the button by hiding overlay alpha

    public func unhighlight() {
        hideOverlay()
        unhighlightAction?(self)
    }

    /// Shortly blinks the overlay
    
    public func impulse(impulseLevel: CGFloat = 0) {
        let attack = SKAction.fadeAlpha(to: 0.3 + impulseLevel, duration: 0.05)
        let decay = SKAction.fadeAlpha(to: 0.3, duration: 0.3)
        let action = SKAction.sequence([
                attack,
                decay
                ])
        overlay?.run(action)

    }
    
    /// Blinks the overlay periodically

    public func startBlinking(impulseLevel: CGFloat = 0) {
        
        let attack = SKAction.fadeAlpha(to: 0.3 + impulseLevel, duration: 0.08)
        let decay = SKAction.fadeAlpha(to: 0.2, duration: 0.33)
        let impulseAction = SKAction.sequence([
                attack,
                decay
                ])

        let action = SKAction.repeatForever(impulseAction)
        overlay?.run(action, withKey: "blink")
    }

    public func stopBlinking() {
        overlay?.removeAction(forKey: "blink")

    }
    
    public func hideOverlay() {
        let action = SKAction.fadeAlpha(to: 0.001, duration: 0.2)
        overlay?.removeAllActions()
        overlay?.run(action)
    }
    
    public override func move(toParent parent: SKNode) {
        super.move(toParent: parent)
        build()
    }
    
    func press() {
        impulse()
    }
    
    func release() {
        hideOverlay()
        self.action?()
    }
}
