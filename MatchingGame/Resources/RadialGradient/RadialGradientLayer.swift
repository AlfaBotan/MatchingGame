//
//  RadialGradientLayer.swift
//  MatchingGame
//
//  Created by Илья Волощик on 31.10.24.
//

import UIKit

class RadialGradientLayer: CALayer {
    var colors: [CGColor] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var radius: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(in ctx: CGContext) {
        guard colors.count > 1 else { return }

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil)!

        // Устанавливаем центр градиента
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        ctx.drawRadialGradient(gradient,
                                startCenter: center,
                                startRadius: 0,
                                endCenter: center,
                                endRadius: radius,
                                options: [.drawsAfterEndLocation])
    }
}
