//   /\/\__/\/\      MFSKExtensions
//   \/\/..\/\/      Extensions for SpriteKit
//      (oo)
//  MooseFactory
//    Software       ©2024 - Tristan Leblanc
//  --------------------------------------------------
//  SpriteSelectScene.swift
//  Created by Tristan Leblanc on 21/12/2024.

import SpriteKit

open class ButtonsScene: SKScene {

    var selectedButton: ButtonNode?
    var overedButton: ButtonNode?
    
    open override func sceneDidLoad() {

    }

    func button(at location: CGPoint) -> ButtonNode? {
        let nodeAtLoc = atPoint(location)
        return nodeAtLoc as? ButtonNode
        ?? nodeAtLoc.parent as? ButtonNode
    }
    
    func selectButton(location: CGPoint) {
        // If a button is already selected, we exit
        guard selectedButton == nil else { return }
        selectedButton = button(at: location)
        overedButton = selectedButton
        selectedButton?.highlight(impulseLevel: 0.2)
    }
    
    func overButton(location: CGPoint) {
        guard let selectedButton = selectedButton else { return }
        let newOveredButton = button(at: location)
        guard overedButton != newOveredButton else { return }
        overedButton = newOveredButton
        if overedButton != selectedButton  {
            selectedButton.unhighlight()
        } else {
            selectedButton.highlight(impulseLevel: 0.05)
        }
    }
    
    func drag(location: CGPoint) {
        selectedButton?.dragAction?(location, selectedButton, overedButton)
    }
    
    func dragEnded(location: CGPoint) {
        selectedButton?.dragEndedAction?(location, selectedButton, overedButton)
    }

    func touchInContent(at location: CGPoint) {
        
    }

//    open func handle(action: Action) {
//        
//    }
    
#if os(macOS)
    
    func eventLocation(for event: NSEvent) -> CGPoint {
        event.location(in: self)
    }
    
    open override func mouseDown(with event: NSEvent) {
        selectButton(location: eventLocation(for: event))
    }
    
    open override func mouseDragged(with event: NSEvent) {
        overButton(location: eventLocation(for: event))
    }
    
    open override func mouseUp(with event: NSEvent) {
        let locationInScene = eventLocation(for: event)
        guard let selectedButton = selectedButton else {
            touchInContent(at: locationInScene)
            return
        }
        eventEnded(at: locationInScene)
    }

#else
    
    func eventLocation(for touches:Set<UITouch>) -> CGPoint {
        touches.first!.location(in: self)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectButton(location: eventLocation(for: touches))
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let loc  = eventLocation(for: touches)
        overButton(location: loc)
        drag(location: loc)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let locationInScene = eventLocation(for: touches)
        dragEnded(location: locationInScene)

        guard let selectedButton = selectedButton else {
            touchInContent(at: locationInScene)
            return
        }
        eventEnded(at: locationInScene)
    }

#endif
    
    func eventEnded(at location: CGPoint) {
        
        self.overedButton = nil
        guard let selectedButton = selectedButton else { return }

        selectedButton.unhighlight()
        
        // Check if we touch up in the button, otherwise action is not triggered
        if button(at: location) == selectedButton {
            selectedButton.action?()
        }
        
        self.selectedButton = nil
    }
    
    open func selectInContent(_ location: CGPoint) {
        
    }
    
    func spriteSelected(_ sprite: SKNode) -> Bool {
        return false
    }
    
    func spriteReleased(_ sprite: SKNode) -> Bool {
        return false
    }
}
