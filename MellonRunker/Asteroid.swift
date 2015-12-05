//
//  Asteroid.swift
//  MellonRunker
//
//  Created by Se-Joon Chung on 12/5/15.
//  Copyright © 2015 Gihyuk Ko. All rights reserved.
//

import SpriteKit

class Asteroid
{
    let asteroid: SKSpriteNode
    
    let asteroidPrefixes: [String] = ["a1","a3","a4","b4","c1","c3","c4","d1","d3","d4"]
    
    // Creates a random asteroid
    init(parentFrame: CGRect)
    {
        let randomIdx = Int(arc4random_uniform(UInt32(asteroidPrefixes.count)))
        let atlasPrefix = asteroidPrefixes[randomIdx]
        let asteroidAtlas = SKTextureAtlas(named: "m\(atlasPrefix)")
        var asteroidFrames = [SKTexture]()
        
        let numImages = asteroidAtlas.textureNames.count
        for var i=0; i<numImages; i++ {
            let textureName = String(format: "%@%04d", atlasPrefix, i)
            asteroidFrames.append(asteroidAtlas.textureNamed(textureName))
        }
        
        let firstFrame = asteroidFrames[0]
        asteroid = SKSpriteNode(texture: firstFrame)
        asteroid.position = CGPoint(x:CGRectGetMidX(parentFrame), y:CGRectGetMidY(parentFrame))
        
        startAnimation(asteroidFrames)
    }
    
    func startAnimation(animationFrames: [SKTexture]) {
        //This is our general runAction method to make our animation start.
        //By using a withKey if this gets called while already running it will remove the first action before starting this again.
        
        asteroid.runAction( SKAction.repeatActionForever(SKAction.animateWithTextures(animationFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey:"animation")
    }
}
