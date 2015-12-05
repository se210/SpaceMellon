//
//  GameScene.swift
//  MellonRunker
//
//  Created by Gihyuk Ko on 11/23/15.
//  Copyright © 2015 Gihyuk Ko and Se-Joon Chung. All rights reserved.
//

// Simply copied from Sally's brickbreaker

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    var spaceship: SKSpriteNode
    var astroid: SKSpriteNode
    
    var paddle: SKSpriteNode
    var isSetup: Bool
    var ballIsMoving: Bool
    var numberOfLives: Int
    var score: Int
    var scoreLabel: SKLabelNode
    var livesLabel: SKLabelNode
    
    var controlpad: SKSpriteNode
    var controller: SKSpriteNode
    
    let kScoreHeight: CGFloat = 44.0
    
    func vecMult(a: CGPoint, b: Float) -> CGPoint {
        return CGPointMake(a.x * CGFloat(b), a.y * CGFloat(b))
    }
    
    func vecLength(a: CGPoint) -> Float {
        return sqrtf(Float(a.x * a.x + a.y * a.y))
    }
    
    // Makes a vector have a length of 1
    func vecNormalize(a: CGPoint) -> CGPoint {
        let length: CGFloat = CGFloat(vecLength(a))
        return CGPointMake(a.x / length, a.y / length);
    }
    
    func CGRectGetCenter(rect: CGRect) -> CGPoint {
        return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    }
    
    override init(size: CGSize) {
        // initialize class variables
        self.score = 0
        self.numberOfLives = 3
        self.isSetup = false
        self.ballIsMoving = false
        self.paddle = SKSpriteNode(imageNamed:"paddle")
        self.spaceship = SKSpriteNode(imageNamed: "spaceship0")
        self.astroid = SKSpriteNode(imageNamed: "astroid")
        self.scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        self.livesLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        self.controller = SKSpriteNode(imageNamed: "controller_dark")
        self.controlpad = SKSpriteNode(imageNamed: "controlpad_dark")
        
        super.init(size: size)
        
        // Set background
        self.backgroundColor = SKColor.greenColor()
        let backgroundImage = SKSpriteNode(imageNamed: "Background")
        backgroundImage.position = CGPointMake(self.frame.midX, self.frame.midY)
        backgroundImage.zPosition = -5.0
        self.addChild(backgroundImage)
        
        self.physicsWorld.gravity = CGVectorMake(0,0)
        self.physicsWorld.contactDelegate = self    // whenever two things contact each other, myself controls it.
        
        //initialize the spaceship
        self.spaceship.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "spaceship0"), size: self.spaceship.size)
        
        self.spaceship.physicsBody?.categoryBitMask = spaceshipCategory
        self.spaceship.physicsBody?.contactTestBitMask = asteroidCategory
        self.spaceship.physicsBody?.affectedByGravity = false
        self.spaceship.physicsBody?.allowsRotation = false
        //self.spaceship.physicsBody?.dynamic = false
        
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        self.spaceship.position = CGRectGetCenter(self.frame)
        
        self.addChild(self.spaceship)
        
        self.controller.alpha = 0.6
        self.controlpad.alpha = 0.4
        self.controller.zPosition = -3.0
        self.controlpad.zPosition = -4.0
        self.controller.hidden = true
        self.controlpad.hidden = true
        self.addChild(self.controller)
        self.addChild(self.controlpad)
        
        
        // initialize the walls and ceiling
        let screenRect = self.frame
        let wallSize = CGSizeMake(1,CGRectGetHeight(screenRect))
        let ceilingSize = CGSizeMake(CGRectGetWidth(screenRect),1)
        
        let leftBoundary = SKSpriteNode(color: UIColor.blackColor(), size: wallSize)
        leftBoundary.physicsBody = SKPhysicsBody(rectangleOfSize: leftBoundary.size)
        leftBoundary.position = CGPointMake(0,CGRectGetMidY(screenRect))    // the center of the boundary
        leftBoundary.physicsBody?.dynamic = false
        leftBoundary.physicsBody?.categoryBitMask = boundaryCategory
        leftBoundary.physicsBody?.contactTestBitMask = spaceshipCategory
        leftBoundary.physicsBody?.collisionBitMask = spaceshipCategory
        
        let rightBoundary = SKSpriteNode(color: UIColor.blackColor(), size: wallSize)
        rightBoundary.physicsBody = SKPhysicsBody(rectangleOfSize: rightBoundary.size)
        rightBoundary.position = CGPointMake(CGRectGetMaxX(screenRect),CGRectGetMidY(screenRect))
        rightBoundary.physicsBody?.dynamic = false
        rightBoundary.physicsBody?.categoryBitMask = boundaryCategory
        rightBoundary.physicsBody?.contactTestBitMask = spaceshipCategory
        rightBoundary.physicsBody?.collisionBitMask = spaceshipCategory
        
        let ceilingBoundary = SKSpriteNode(color: UIColor.blackColor(), size: ceilingSize)
        ceilingBoundary.physicsBody = SKPhysicsBody(rectangleOfSize: ceilingBoundary.size)
        ceilingBoundary.position = CGPointMake(CGRectGetMidX(screenRect),CGRectGetMaxY(screenRect) - self.kScoreHeight / 2.0)  // take a room for the scores labels
        ceilingBoundary.physicsBody?.dynamic = false
        ceilingBoundary.physicsBody?.categoryBitMask = boundaryCategory
        ceilingBoundary.physicsBody?.contactTestBitMask = spaceshipCategory
        ceilingBoundary.physicsBody?.collisionBitMask = spaceshipCategory
        
        let floorBoundary = SKSpriteNode(color:UIColor.blackColor(), size: ceilingSize)
        floorBoundary.physicsBody = SKPhysicsBody(rectangleOfSize: floorBoundary.size)
        floorBoundary.position = CGPointMake(CGRectGetMidX(screenRect),CGRectGetMinY(screenRect))
        floorBoundary.physicsBody?.dynamic = false
        floorBoundary.physicsBody?.categoryBitMask = boundaryCategory
        floorBoundary.physicsBody?.contactTestBitMask = spaceshipCategory
        floorBoundary.physicsBody?.collisionBitMask = spaceshipCategory
        
        self.addChild(leftBoundary)
        self.addChild(rightBoundary)
        self.addChild(ceilingBoundary)
        self.addChild(floorBoundary)
        
        let farBoundarySize = CGSize(width: screenRect.width+200, height: screenRect.height+200)
        let farBoundaryOrigin = CGPoint(x: screenRect.midX-farBoundarySize.width/2.0, y: screenRect.midY-farBoundarySize.height/2.0)
        let farBoundaryRect = CGRect(origin: farBoundaryOrigin, size: farBoundarySize)
        let farBoundary = SKNode()
        farBoundary.physicsBody = SKPhysicsBody(edgeLoopFromRect: farBoundaryRect)
        farBoundary.physicsBody?.categoryBitMask = farBoundaryCategory
        farBoundary.physicsBody?.contactTestBitMask = asteroidCategory
        farBoundary.physicsBody?.collisionBitMask = 0
        self.addChild(farBoundary)
    }
    
    override func didMoveToView(view: SKView) {
        if (!isSetup) { // when the game is not setup
            var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("generateAsteroids"), userInfo: nil, repeats: true)
            //self.setupSceneWithBlocks()
            self.setupScoreDisplay()
            self.isSetup = true
        }
    }
    
    func setupScoreDisplay() {
        self.scoreLabel.name = "scoreLabel"
        self.scoreLabel.fontColor = SKColor.whiteColor()
        self.scoreLabel.text = "Score: 0"
        self.scoreLabel.fontSize = 18.0
        self.scoreLabel.position = CGPointMake(5 + self.scoreLabel.frame.size.width / 2.0,
            CGRectGetMaxY(self.frame) - self.scoreLabel.frame.size.height)
        self.addChild(self.scoreLabel)
        
        self.livesLabel.name = "livesLabel"
        self.livesLabel.fontColor = SKColor.whiteColor()
        self.livesLabel.text = "Lives: 3"
        self.livesLabel.fontSize = 18.0
        self.livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left   // align text left side
        self.livesLabel.position = CGPointMake(CGRectGetMaxX(self.frame) - self.livesLabel.frame.size.width / 2.0 - 5,
            CGRectGetMaxY(self.frame) - self.livesLabel.frame.size.height)
        self.addChild(self.livesLabel)
    }
    
    // generate
    func generateAsteroids() {
        for _ in 1...5
        {
            let asteroid = Asteroid(parentFrame: self.frame)
            asteroid.zPosition = 1.0
            addChild(asteroid)
        }
    }
    /*
    // Setup the blocks for the game
    func setupSceneWithBlocks() {
        // Start in the upper left corner just under the score label
        var startingX: CGFloat = 0.0
        var startingY: CGFloat = kScoreHeight
        var colors: [SKColor] = [SKColor.redColor(),
            SKColor.orangeColor(),
            SKColor.yellowColor(),
            SKColor.greenColor(),
            SKColor.blueColor(),
            SKColor.purpleColor()]
        let blockHeight: CGFloat = 22
        let blockWidth: CGFloat = self.size.width / 12.0
        var col: Int = 0
        
        // Create and add blocks to scene. This will create 4 rows and 12 columns.
        // Outer loop: rows (loop guard might seem weird, but that's because startingY isn't 0
        // Inner loop: columns
        while(startingY < (blockHeight * 6)) {
            while(startingX < self.size.width) {
                let block = SKSpriteNode(texture:SKTexture(imageNamed: "block"),
                    color: colors[col % colors.count], size: CGSizeMake(blockWidth,blockHeight))
                block.colorBlendFactor = 0.7
                
                block.position = CGPointMake(startingX + blockWidth / 2.0, self.size.height - startingY + blockHeight / 2.0)
                
                block.physicsBody = SKPhysicsBody(rectangleOfSize: block.size)
                block.physicsBody?.categoryBitMask = blockCategory
                block.physicsBody?.contactTestBitMask = ballCategory
                block.physicsBody?.affectedByGravity = false
                block.physicsBody?.dynamic = false
                
                self.addChild(block)
                
                // increment
                startingX += blockWidth
                col++
            }
            //increment and reset counters for next row
            startingY += blockHeight
            startingX = 0
            col = 0
        }
    } */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var randomXOffset: CGFloat = (CGFloat(random()) / CGFloat(RAND_MAX)) / 1.5  // generating random direction which ball moves
        if(arc4random() % 2 == 0) {
            randomXOffset *= -1.0
        }
        
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        
        if (!self.ballIsMoving) {
            self.spaceship.physicsBody?.applyImpulse(CGVectorMake(randomXOffset, -2))
            self.ballIsMoving = true
        }
        
        // move controller and controlpad at location and reveal
        self.controlpad.position = location
        self.controller.position = location
        self.controlpad.hidden = false
        self.controller.hidden = false
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        let padradius = self.controlpad.size.width / 3.0
        let padlocation = self.controlpad.position
        let difference = CGPointMake(location.x - padlocation.x, location.y - padlocation.y)
        
        // move controller on controlpad according to its direction
        if (vecLength(difference) > Float(padradius)) {
            let motivation = CGPointMake(padradius * vecNormalize(difference).x,
                                         padradius * vecNormalize(difference).y)
            self.controller.position = CGPointMake(padlocation.x + motivation.x,
                                                   padlocation.y + motivation.y)
            self.moveShipByVector(difference)
        } else {
            self.controller.position = location
            self.moveShipByVector(difference)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // hide controller and controlpad
        self.controlpad.hidden = true
        self.controller.hidden = true
    }
    
    func moveShipByVector(point: CGPoint) {
        let spaceshipVector = self.spaceship.physicsBody!.velocity
        
        // change texture as velocity changes
        if (vecLength(CGPointMake(spaceshipVector.dx, spaceshipVector.dy)) < 50) {
            self.spaceship.texture = SKTexture(imageNamed: "spaceship0")
        } else if (vecLength(CGPointMake(spaceshipVector.dx, spaceshipVector.dy)) < 100) {
            self.spaceship.texture = SKTexture(imageNamed: "spaceship1")
        } else if (vecLength(CGPointMake(spaceshipVector.dx, spaceshipVector.dy)) < 150) {
            self.spaceship.texture = SKTexture(imageNamed: "spaceship2")
        } else {
            self.spaceship.texture = SKTexture(imageNamed: "spaceship3")
        }
        
        // set the rotation for the spaceship
        if (point.y > 0) {
            self.spaceship.zRotation = atan(-point.x/point.y)
        } else {
            self.spaceship.zRotation = CGFloat(M_PI) + atan(-point.x/point.y)
        }
        self.spaceship.physicsBody?.velocity = CGVectorMake(point.x, point.y)
    }
    
    override func update(currentTime: CFTimeInterval) { // check if the player lost the game
        if (self.spaceship.position.y < 0) {
            // reset ball
            self.spaceship.physicsBody?.velocity = CGVectorMake(0,0)
            self.spaceship.position = CGRectGetCenter(self.frame)
            self.ballIsMoving = false
            
            // decrement number of lives
            self.numberOfLives--
            self.livesLabel.text = "Lives: \(self.numberOfLives)"
        }
    }
    
    // called whenever the contact happened: method from SKPhysicsContactDelegate
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // if spaceship and asteroid collided
        if (firstBody.categoryBitMask & asteroidCategory != 0 && secondBody.categoryBitMask & spaceshipCategory != 0) {
            // reset spaceship
            self.explosion()
            self.spaceship.physicsBody?.velocity = CGVectorMake(0,0)
            self.spaceship.position = CGRectGetCenter(self.frame)
            self.ballIsMoving = false
            
            // decrement number of lives
            self.numberOfLives--
            self.livesLabel.text = "Lives: \(self.numberOfLives)"
        }
        // if asteroid hit a boundary
        else if (firstBody.categoryBitMask & asteroidCategory != 0 && secondBody.categoryBitMask & farBoundaryCategory != 0)
        {
            if let asteroid = firstBody.node as? Asteroid
            {
                asteroid.removeFromParent()
                self.score++
                self.scoreLabel.text = "Score: \(self.score)"
            }
        }
    }
    
    func explosion() {
        let explosionAtlas = SKTextureAtlas(named: "Explosion")
        var explosionFrames = [SKTexture]()
        let numImages = explosionAtlas.textureNames.count
        for (var i=0; i<numImages; i++) {
            let textureName = String(format: "expl_07_%04d", i)
            explosionFrames.append(explosionAtlas.textureNamed(textureName))
        }
        let firstFrame = explosionFrames[0]
        self.spaceship.texture = firstFrame
        startAnimation(explosionFrames)
        
    }
    
    func startAnimation(animationFrames: [SKTexture]) {
        //This is our general runAction method to make our animation start.
        //By using a withKey if this gets called while already running it will remove the first action before starting this again.
        self.spaceship.runAction(SKAction.animateWithTextures(animationFrames, timePerFrame: 0.05, resize: false, restore: true), withKey:"animation")
    }
    
    func handleContact(ball: SKSpriteNode, block: SKSpriteNode) {
        // remove the block that the ball hit and then increase score
        block.removeFromParent()
        self.score++
        self.scoreLabel.text = "Score: \(self.score)"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
