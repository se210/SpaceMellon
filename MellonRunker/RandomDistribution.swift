//
//  RandomDistribution.swift
//  MellonRunker
//
//  Created by Se-Joon Chung on 12/5/15.
//  Copyright © 2015 Gihyuk Ko. All rights reserved.
//

import Foundation

class GaussianRandomDistribution
{
    class func sample(mean: Double, stdev: Double) -> Double
    {
        let u1 = Double(arc4random()) / Double(UINT32_MAX) // uniform distribution
        let u2 = Double(arc4random()) / Double(UINT32_MAX) // uniform distribution
        let f1 = sqrt(-2 * log(u1))
        let f2 = 2 * M_PI * u2
        let g1 = f1 * cos(f2) // gaussian distribution
//        let g2 = f1 * sin(f2) // gaussian distribution
        
        return g1 * stdev + mean
    }
}

class UniformRandomDistribution
{
    class func sample(min: Double, max: Double) -> Double
    {
        let u1 = Double(arc4random()) / Double(UINT32_MAX) // uniform distribution
        
        return u1 * (max-min) + min
    }
}
