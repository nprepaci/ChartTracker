//
//  Emitter.swift
//  PagesOfPain
//
//  Created by Nicholas Repaci on 9/30/20.
//

import Foundation
import UIKit
import SpriteKit

class Emitter {
    
    func particleEmitter(view: UIView, fileName: String, xval: Int, yval: Int) {
        let sk: SKView = SKView()
        sk.frame = view.bounds
        sk.backgroundColor = .clear
        view.addSubview(sk)

        let scene: SKScene = SKScene(size: view.bounds.size)
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .clear

        let en = SKEmitterNode(fileNamed: fileName)
        //position of emitter on 2d plane
        en?.position = CGPoint(x:xval, y:yval)

        scene.addChild(en!)
        sk.presentScene(scene)
        //zposition brought emitter to front of view to make visible
        //scene.zPosition = 1
    
    }
    
    func particleEmitterTiedToButton(view: UIView, fileName: String, location: UIButton, xCoordinateMod: CGFloat, yCoordinateMod: CGFloat) {
        let sk: SKView = SKView()
        sk.frame = view.bounds
        sk.backgroundColor = .clear
        view.addSubview(sk)

        let scene: SKScene = SKScene(size: view.bounds.size)
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .clear

        let en = SKEmitterNode(fileNamed: fileName)
        //gets location of UI button (origin is the x,y value)
        let distanceFromOrigin = location.frame.origin
        //xvalue of button
        let xVal = distanceFromOrigin.x
        //yvalue of button
        let yVal = distanceFromOrigin.y
        en?.position = CGPoint(x:xVal + xCoordinateMod, y:yVal + yCoordinateMod)

        scene.addChild(en!)
        sk.presentScene(scene)
    
    }
    
    func particleEmitterTiedToUiView(view: UIView, fileName: String, location: UIView, xCoordinateMod: CGFloat, yCoordinateMod: CGFloat) {
        let sk: SKView = SKView()
        sk.frame = view.bounds
        sk.backgroundColor = .clear
        view.addSubview(sk)

        let scene: SKScene = SKScene(size: view.bounds.size)
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .clear

        let en = SKEmitterNode(fileNamed: fileName)
        //gets location of UI button (origin is the x,y value)
        let distanceFromOrigin = location.frame.origin
        //xvalue of button
        let xVal = distanceFromOrigin.x
        //yvalue of button
        let yVal = distanceFromOrigin.y
        en?.position = CGPoint(x:xVal + xCoordinateMod, y:yVal + yCoordinateMod)
        
    

        scene.addChild(en!)
        sk.presentScene(scene)
    
    }
}
