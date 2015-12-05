//
//  SpriteCategories.swift
//  MellonRunker
//
//  Created by Gihyuk Ko on 11/23/15.
//  Copyright © 2015 Gihyuk Ko. All rights reserved.
//

import Foundation

// constants for the physics body bit masks used in contact/collision detection
let rockCategory: UInt32  = 0x1 << 0
let spaceshipCategory: UInt32 = 0x1 << 1
let paddleCategory: UInt32 = 0x1 << 2
let ballCategory: UInt32 = 0x1 << 3
let blockCategory: UInt32 = 0x1 << 4