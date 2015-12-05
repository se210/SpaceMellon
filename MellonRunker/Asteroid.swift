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
    
    let asteroidNames: [String] = ["a1","a3","a4","b4","c1","c3","c4","d1","d3","d4"]
    
    // Creates a random asteroid
    init(parentFrame: CGRect)
    {
        let randomIdx = Int(arc4random_uniform(UInt32(asteroidNames.count)))
        let asteroidName = asteroidNames[randomIdx]
        
        asteroid = SKSpriteNode(imageNamed: asteroidName)
        
        // get random starting position
        asteroid.position = CGPoint(x:CGRectGetMidX(parentFrame), y:CGRectGetMidY(parentFrame))
        
        // asteroid physics
        asteroid.physicsBody = SKPhysicsBody(texture: asteroid.texture!, size: asteroid.size)
        asteroid.physicsBody?.categoryBitMask = astroidCategory
        asteroid.physicsBody?.contactTestBitMask = spaceshipCategory
        asteroid.physicsBody?.affectedByGravity = false
        asteroid.physicsBody?.dynamic = true
        
        // get random velocity
        let angle = UniformRandomDistribution.sample(0.0, max: 2 * M_PI)
        let speed = GaussianRandomDistribution.sample(100.0, stdev: 100.0)
        asteroid.physicsBody?.velocity = CGVector(dx: speed * cos(angle), dy: speed * sin(angle))
        asteroid.physicsBody?.angularVelocity = -CGFloat(2 * M_PI)
    }
}
