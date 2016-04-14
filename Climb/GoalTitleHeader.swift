//
//  GoalTitleHeader.swift
//  Climb
//
//  Created by Justin Smith on 2/9/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class GoalTitleHeader: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    /*- (void)drawRect:(CGRect)rect {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(-15, 20), 5);
    [super drawRect: rect];
    CGContextRestoreGState(currentContext);
    } */
    override func drawRect(rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        CGContextSetShadow(context, CGSizeMake(0, 18), 2)
            super.drawRect(rect)
        CGContextRestoreGState(context)
    }

}
