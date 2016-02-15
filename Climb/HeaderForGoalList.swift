//
//  Class2D.swift
//  coreGraphicsPractice
//
//  Created by Justin Smith on 2/8/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class Class2D: UIView
{

     //Only override drawRect: if you perform custom drawing.
     //An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        //CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200)
        UIView.animateWithDuration(10.0) { () -> Void in
            let bezier = UIBezierPath()
            bezier.moveToPoint(CGPoint(x: 0, y: self.center.y))
            //bezier.addLineToPoint(CGPoint(x: 50, y: self.center.y))
            //bezier.addLineToPoint(CGPoint(x: 100, y: self.center.y - 50))
            //bezier.addLineToPoint(CGPoint(x: self.frame.width - 100, y: self.center.y - 50))
            //bezier.addLineToPoint(CGPoint(x: self.frame.width - 50, y: self.center.y))
            bezier.addLineToPoint(CGPoint(x: self.frame.width, y: self.center.y))
            UIColor.blackColor().setStroke()
            bezier.lineWidth = 6
            bezier.stroke()
        }
        
    }
}
