//
//  GameViewController.swift
//  AppleCalculator
//
//  Created by Rasmus Gulbaek on 21/10/2016.
//  Copyright © 2016 Gulbaek I/S. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                //sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
//                sceneNode.scaleMode = .aspectFill
                sceneNode.scaleMode = .aspectFit
                
                
                //sceneNode.backgroundColor = UIColor(red: 216/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = false
                    view.showsNodeCount = false
                    view.showsPhysics = false
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
