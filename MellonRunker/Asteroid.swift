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
        // side - 0: top, 1: right, 2: bottom, 3: left
        let side = arc4random_uniform(4)
        var xpos: CGFloat
        var ypos: CGFloat
        if (side % 2 == 0)
        {
            xpos = CGFloat(UniformRandomDistribution.sample(Double(parentFrame.minX),
                                                            max: Double(parentFrame.maxX)))
            if (side == 0)
            {
                ypos = parentFrame.maxY + 100.0
            }
            else
            {
                ypos = parentFrame.minY - 100.0
            }
        }
        else
        {
            ypos = CGFloat(UniformRandomDistribution.sample(Double(parentFrame.minY),
                max: Double(parentFrame.maxY)))
            if (side == 1)
            {
                xpos = parentFrame.maxX + 100.0
            }
            else
            {
                xpos = parentFrame.minX - 100.0
            }

        }
        
        asteroid.position = CGPoint(x: xpos, y: ypos)
        
        // asteroid physics
        asteroid.physicsBody = SKPhysicsBody(texture: asteroid.texture!, size: asteroid.size)
        asteroid.physicsBody?.categoryBitMask = asteroidCategory
        asteroid.physicsBody?.contactTestBitMask = spaceshipCategory
        asteroid.physicsBody?.collisionBitMask = spaceshipCategory
        asteroid.physicsBody?.affectedByGravity = false
        asteroid.physicsBody?.dynamic = true
        asteroid.physicsBody?.restitution = 1.0
        
        // get random velocity
        let meanSpeed = 100.0
        let stdevSpeed = 30.0
        var xspeed = abs(GaussianRandomDistribution.sample(meanSpeed, stdev: stdevSpeed))
        if (side == 1)
        {
            xspeed = -xspeed
        }
        
        var yspeed = abs(GaussianRandomDistribution.sample(meanSpeed, stdev: stdevSpeed))
        if (side == 0)
        {
            yspeed = -yspeed
        }
        
        asteroid.physicsBody?.velocity = CGVector(dx: xspeed, dy: yspeed)
        asteroid.physicsBody?.angularVelocity = -CGFloat(2 * M_PI)
    }
}
