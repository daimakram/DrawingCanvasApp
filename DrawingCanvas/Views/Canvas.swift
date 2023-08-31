//
//  Canvas.swift
//  DrawingCanvas
//
//  Created by Daim Armaghan on 31/08/2023.
//

import UIKit

class Canvas: UIView {
    
    var lines = [[CGPoint]]()
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(5)
        context.setLineCap(.round)
        
        lines.forEach{ (line) in
            for (i,p) in line.enumerated() {
                if i==0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        context.strokePath()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {return}
        print(point)
        
        guard var lastLine = lines.popLast() else {return}
        
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
}
