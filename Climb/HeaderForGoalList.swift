//
//  Class2D.swift
//  coreGraphicsPractice
//
//  Created by Justin Smith on 2/8/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class HeaderForGoalList: UIView
{    
     //Only override drawRect: if you perform custom drawing.
     //An empty implementation adversely affects performance during animation.
    
    var lineColor: UIColor?
    
    override func drawRect(rect: CGRect)
    {
        UIView.animateWithDuration(10.0) { () -> Void in
            let bezier = UIBezierPath()
            bezier.moveToPoint(CGPoint(x: 0, y: self.frame.height - 2))
            bezier.addLineToPoint(CGPoint(x: self.center.x - 45, y: self.frame.height - 2))
            bezier.addLineToPoint(CGPoint(x: self.center.x - 25, y: self.frame.height - 30))
            bezier.addLineToPoint(CGPoint(x: self.center.x + 25, y: self.frame.height - 30))
            bezier.addLineToPoint(CGPoint(x: self.center.x + 45, y: self.frame.height - 2))
            bezier.addLineToPoint(CGPoint(x: self.frame.width, y: self.frame.height - 2))
            
            if let color = self.lineColor
            {
                color.setStroke()
            }
            
            bezier.lineWidth = 2
            bezier.stroke()
        }
        
    }
}
