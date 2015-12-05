//
//  GameScene.swift
//  MellonRunker
//
//  Created by Gihyuk Ko on 11/23/15.
//  Copyright © 2015 Gihyuk Ko. All rights reserved.
//

// Simply copied from Sally's brickbreaker

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    var spaceship: SKSpriteNode
    
    var paddle: SKSpriteNode
    var isSetup: Bool
    var ballIsMoving: Bool
    var numberOfLives: Int
    var score: Int
    var scoreLabel: SKLabelNode
    var livesLabel: SKLabelNode
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
        self.spaceship = SKSpriteNode(imageNamed: "ball")
        self.paddle = SKSpriteNode(imageNamed:"paddle")
        self.scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        self.livesLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        
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
        self.spaceship.physicsBody = SKPhysicsBody(circleOfRadius: self.spaceship.size.width / 2.0)  // ball is an image
        
        self.spaceship.physicsBody?.categoryBitMask = spaceshipCategory
        self.spaceship.physicsBody?.contactTestBitMask = rockCategory
        self.spaceship.physicsBody?.affectedByGravity = false
        self.spaceship.physicsBody?.dynamic = false
        
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        self.spaceship.position = CGRectGetCenter(self.frame)
        
        self.spaceship.physicsBody?.friction = 0.0
        
        self.addChild(self.spaceship)
        
        // initialize the paddle
        self.paddle.physicsBody = SKPhysicsBody(rectangleOfSize: self.paddle.size)
        
        self.paddle.physicsBody?.categoryBitMask = paddleCategory
        self.paddle.physicsBody?.contactTestBitMask = ballCategory
        self.paddle.physicsBody?.affectedByGravity = false
        self.paddle.physicsBody?.dynamic = false    // paddle is not moved by physics simulation
        
        var centerPoint = CGRectGetCenter(self.frame)
        centerPoint.y = self.paddle.size.height / 2.0
        self.paddle.position = centerPoint
        
        self.addChild(self.paddle)
        
        // initialize the walls and ceiling
        let screenRect = self.frame
        let wallSize = CGSizeMake(1,CGRectGetHeight(screenRect))
        let ceilingSize = CGSizeMake(CGRectGetWidth(screenRect),1)
        
        let leftBoundary = SKSpriteNode(color: UIColor.blackColor(), size: wallSize)
        leftBoundary.physicsBody = SKPhysicsBody(rectangleOfSize: leftBoundary.size)
        leftBoundary.position = CGPointMake(0,CGRectGetMidY(screenRect))    // the center of the boundary
        leftBoundary.physicsBody?.dynamic = false
        
        let rightBoundary = SKSpriteNode(color: UIColor.blackColor(), size: wallSize)
        rightBoundary.physicsBody = SKPhysicsBody(rectangleOfSize: rightBoundary.size)
        rightBoundary.position = CGPointMake(CGRectGetMaxX(screenRect),CGRectGetMidY(screenRect))
        rightBoundary.physicsBody?.dynamic = false
        
        let ceilingBoundary = SKSpriteNode(color: UIColor.blackColor(), size: ceilingSize)
        ceilingBoundary.physicsBody = SKPhysicsBody(rectangleOfSize: ceilingBoundary.size)
        ceilingBoundary.position = CGPointMake(CGRectGetMidX(screenRect),CGRectGetMaxY(screenRect) - self.kScoreHeight / 2.0)  // take a room for the scores labels
        ceilingBoundary.physicsBody?.dynamic = false
        
        self.addChild(leftBoundary)
        self.addChild(rightBoundary)
        self.addChild(ceilingBoundary)
    }
    
    override func didMoveToView(view: SKView) {
        if (!isSetup) { // when the game is not setup
            self.setupSceneWithBlocks()
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
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var randomXOffset: CGFloat = (CGFloat(random()) / CGFloat(RAND_MAX)) / 1.5  // generating random direction which ball moves
        if(arc4random() % 2 == 0) {
            randomXOffset *= -1.0
        }
        
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        self.movePaddleToPoint(location)    // call movePaddleToPoint method
        
        if (!self.ballIsMoving) {
            self.spaceship.physicsBody?.applyImpulse(CGVectorMake(randomXOffset, -2))
            self.ballIsMoving = true
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        self.movePaddleToPoint(location)
    }
    
    func movePaddleToPoint(point: CGPoint) {
        let movePaddleAction = SKAction.moveTo(CGPointMake(point.x, self.paddle.position.y), duration: 0.1) // make an action which moves paddle
        self.paddle.runAction(movePaddleAction)
    }
    
    override func update(currentTime: CFTimeInterval) { // check if the player lost the game
        if (self.spaceship.position.y < 0) {
            // reset ball
            self.spaceship.physicsBody?.velocity = CGVectorMake(0,0)
            self.spaceship.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
            self.ballIsMoving = false
            
            // reset paddle position
            var centerPoint = CGRectGetCenter(self.frame)
            centerPoint.y = self.paddle.size.height / 2.0
            self.paddle.position = centerPoint
            
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
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        else {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        
        // if ball and paddle collided
        if (firstBody.categoryBitMask & paddleCategory != 0 && secondBody.categoryBitMask & ballCategory != 0) {
            let ballVector = self.spaceship.physicsBody!.velocity
            let normalPoint = vecNormalize(CGPointMake(ballVector.dx,ballVector.dy))
            let scaledPoint = vecMult(normalPoint, b: 0.04) // impulse we want to apply
            self.spaceship.physicsBody?.applyImpulse(CGVectorMake(scaledPoint.x,scaledPoint.y))
        }
    }
    
    func handleContact(ball: SKSpriteNode, block: SKSpriteNode) {
        // TODO
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}