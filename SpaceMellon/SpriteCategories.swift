//
//  SpriteCategories.swift
//  SpaceMellon
//
//  Created by Gihyuk Ko on 11/23/15.
//  Copyright © 2015 Gihyuk Ko and Se-Joon Chung. All rights reserved.
//

import Foundation

// constants for the physics body bit masks used in contact/collision detection
let asteroidCategory: UInt32  = 0x1 << 0
let spaceshipCategory: UInt32 = 0x1 << 1
let boundaryCategory: UInt32 = 0x1 << 2
let farBoundaryCategory: UInt32 = 0x1 << 3
