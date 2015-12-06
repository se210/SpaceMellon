//
//  Asteroid.swift
//  SpaceMellon
//
//  Created by Se-Joon Chung on 12/5/15.
//  Copyright © 2015 Gihyuk Ko and Se-Joon Chung. All rights reserved.
//

import SpriteKit

class Asteroid : SKSpriteNode
{
    let asteroidNames: [String] = ["a1","a3","a4","b4","c1","c3","c4","d1","d3","d4"]
    
    var boundaryCollisionCount = 0
    
    // Creates a random asteroid
    init(parentFrame: CGRect)
    {
        let randomIdx = Int(arc4random_uniform(UInt32(asteroidNames.count)))
        let asteroidName = asteroidNames[randomIdx]
        let scaleFactor: CGFloat = 0.7
        
        let asteroidTexture = SKTexture(imageNamed: asteroidName)
        let asteroidSize = CGSizeMake(asteroidTexture.size().width * scaleFactor, asteroidTexture.size().height * scaleFactor)
        super.init(texture: asteroidTexture, color: UIColor.whiteColor(), size: asteroidSize)
        
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
                ypos = parentFrame.maxY + 50.0
            }
            else
            {
                ypos = parentFrame.minY - 50.0
            }
        }
        else
        {
            ypos = CGFloat(UniformRandomDistribution.sample(Double(parentFrame.minY),
                max: Double(parentFrame.maxY)))
            if (side == 1)
            {
                xpos = parentFrame.maxX + 50.0
            }
            else
            {
                xpos = parentFrame.minX - 50.0
            }

        }
        
        self.position = CGPoint(x: xpos, y: ypos)
        
        // asteroid physics
        self.physicsBody = SKPhysicsBody(texture: asteroidTexture, size: asteroidSize)
        self.physicsBody?.categoryBitMask = asteroidCategory
        self.physicsBody?.contactTestBitMask = spaceshipCategory|farBoundaryCategory
        self.physicsBody?.collisionBitMask = spaceshipCategory
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = true
        self.physicsBody?.restitution = 1.0
        
        // get random velocity
        let meanSpeed = 80.0
        let stdevSpeed = 20.0
        var xspeed = abs(GaussianRandomDistribution.sample(meanSpeed, stdev: stdevSpeed))
        if (xpos > parentFrame.midX)
        {
            xspeed = -xspeed
        }
        
        var yspeed = abs(GaussianRandomDistribution.sample(meanSpeed, stdev: stdevSpeed))
        if (ypos > parentFrame.midY)
        {
            yspeed = -yspeed
        }
        
        self.physicsBody?.velocity = CGVector(dx: xspeed, dy: yspeed)
        self.physicsBody?.angularVelocity = -CGFloat(2 * M_PI)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
