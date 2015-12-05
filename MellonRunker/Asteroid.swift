//
//  Asteroid.swift
//  MellonRunker
//
//  Created by Se-Joon Chung on 12/5/15.
//  Copyright © 2015 Gihyuk Ko and Se-Joon Chung. All rights reserved.
//

import SpriteKit

class Asteroid
{
    let asteroid: SKSpriteNode
    
    let asteroidNames: [String] = ["a1","a3","a4","b4","c1","c3","c4","d1","d3","d4"]
    
    // Creates a random asteroid
    init(parentFrame: CGRect)
    {
        let randomIdx = Int(arc4random_uniform(UInt32(asteroidNames.count)))
        let asteroidName = asteroidNames[randomIdx]
        
        asteroid = SKSpriteNode(imageNamed: asteroidName)
        
        // get random starting position within boundary
        var x = CGFloat(UniformRandomDistribution.sample(50.0, max: 200.0))
        var xpos: CGFloat = parentFrame.maxX + x
        if (UniformRandomDistribution.sample(-1.0, max: 1.0) < 0.0)
        {
            x = -x
            xpos = x
        }
        
        var y = CGFloat(UniformRandomDistribution.sample(50.0, max: 200.0))
        var ypos: CGFloat = parentFrame.maxY + y
        if (UniformRandomDistribution.sample(-1.0, max: 1.0) < 0.0)
        {
            y = -y
            ypos = y
        }
        
        asteroid.position = CGPoint(x: xpos, y: ypos)
//        asteroid.position = CGPoint(x: parentFrame.midX, y: parentFrame.midY)
        
        // asteroid physics
        asteroid.physicsBody = SKPhysicsBody(texture: asteroid.texture!, size: asteroid.size)
        asteroid.physicsBody?.categoryBitMask = asteroidCategory
        asteroid.physicsBody?.contactTestBitMask = spaceshipCategory
        asteroid.physicsBody?.collisionBitMask = spaceshipCategory
        asteroid.physicsBody?.affectedByGravity = false
        asteroid.physicsBody?.dynamic = true
        
        // get random velocity
        let meanSpeed = 100.0
        let stdevSpeed = 100.0
        var xspeed = GaussianRandomDistribution.sample(meanSpeed, stdev: stdevSpeed)
        if (x < 0)
        {
            xspeed = abs(xspeed)
        }
        
        var yspeed = GaussianRandomDistribution.sample(meanSpeed, stdev: stdevSpeed)
        if (y < 0)
        {
            yspeed = abs(yspeed)
        }
        
        asteroid.physicsBody?.velocity = CGVector(dx: xspeed, dy: yspeed)
        asteroid.physicsBody?.angularVelocity = -CGFloat(2 * M_PI)
    }
}
