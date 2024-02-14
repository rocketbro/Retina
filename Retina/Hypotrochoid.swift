//
//  Hypotrochoid.swift
//  Retina
//
//  Created by Asher Pope on 1/23/24.
//

import SwiftUI

struct Hypotrochoid: Shape {
    let R: Int
    let r: Int
    let d: Int
    let amount: Double
    let scale: Double
    let xRotation: Double
    let yRotation: Double
    
    // Calculate the greatest common divider using Euclid's algorithm
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    // the shape needs doubles, so that's where all the conversion comes in
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(R, r)
        let R = Double(R)
        let r = Double(self.r)
        let d = Double(self.d)
        let endPoint = ceil(2 * Double.pi * r / Double(divisor)) * amount
        
        // complex mathematics copied from the interwebs
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = ((R - r) * cos(theta) + d * cos((R - r) / r * theta) * xRotation) * scale
            var y = ((R - r) * sin(theta) - d * sin((R - r) / r * theta) * yRotation) * scale
            
            // center path in CGRect:
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
    
}


