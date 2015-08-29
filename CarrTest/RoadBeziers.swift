//
//  RoadBeziers.swift
//  TrafficControl
//
//  Created by Arturs Derkintis on 8/25/15.
//  Copyright © 2015 Starfly. All rights reserved.
//

import UIKit

public func beziers() -> [UIBezierPath] {
  
    //// VerticalLeftStraight Drawing
    let verticalLeftStraightPath = UIBezierPath()
    verticalLeftStraightPath.moveToPoint(CGPointMake(494, 855))
    verticalLeftStraightPath.addLineToPoint(CGPointMake(494, -135))
    verticalLeftStraightPath.name = BezierType.Straight
    
    
    //// VerticalRightStraight Drawing
    let verticalRightStraightPath = UIBezierPath()
    verticalRightStraightPath.moveToPoint(CGPointMake(537, -172))
    verticalRightStraightPath.addLineToPoint(CGPointMake(537, 901))
    verticalRightStraightPath.name = BezierType.Straight
    
    //// VerticalRightTurnRight Drawing
    let verticalRightTurnRightPath = UIBezierPath()
    verticalRightTurnRightPath.moveToPoint(CGPointMake(537, -172))
    verticalRightTurnRightPath.addCurveToPoint(CGPointMake(537, 294), controlPoint1: CGPointMake(537, -172), controlPoint2: CGPointMake(537, 225))
    verticalRightTurnRightPath.addCurveToPoint(CGPointMake(611, 366), controlPoint1: CGPointMake(537, 363), controlPoint2: CGPointMake(538, 366))
    verticalRightTurnRightPath.addCurveToPoint(CGPointMake(1290, 366), controlPoint1: CGPointMake(684, 366), controlPoint2: CGPointMake(1290, 366))
    verticalRightTurnRightPath.name = BezierType.Right
    
    
    //// VerticalRightTurnLeft Drawing
    let verticalRightTurnLeftPath = UIBezierPath()
    verticalRightTurnLeftPath.moveToPoint(CGPointMake(536, -134))
    verticalRightTurnLeftPath.addCurveToPoint(CGPointMake(536.5, 363.5), controlPoint1: CGPointMake(536, -134), controlPoint2: CGPointMake(536.5, 331.5))
    verticalRightTurnLeftPath.addCurveToPoint(CGPointMake(492.5, 406.5), controlPoint1: CGPointMake(536.5, 395.5), controlPoint2: CGPointMake(526.5, 406.5))
    verticalRightTurnLeftPath.addCurveToPoint(CGPointMake(-168, 406), controlPoint1: CGPointMake(458.5, 406.5), controlPoint2: CGPointMake(-168, 406))
    verticalRightTurnLeftPath.name = BezierType.Left
    
    
    //// VerticalLeftTurnLeft Drawing
    let verticalLeftTurnLeftPath = UIBezierPath()
    verticalLeftTurnLeftPath.moveToPoint(CGPointMake(493.5, 874.5))
    verticalLeftTurnLeftPath.addCurveToPoint(CGPointMake(493.5, 405.5), controlPoint1: CGPointMake(493.5, 874.5), controlPoint2: CGPointMake(493.5, 444.5))
    verticalLeftTurnLeftPath.addCurveToPoint(CGPointMake(534.5, 365.5), controlPoint1: CGPointMake(493.5, 366.5), controlPoint2: CGPointMake(520.5, 365.5))
    verticalLeftTurnLeftPath.addCurveToPoint(CGPointMake(1182.5, 365.5), controlPoint1: CGPointMake(548.5, 365.5), controlPoint2: CGPointMake(1182.5, 365.5))
    verticalLeftTurnLeftPath.name = BezierType.Left
    
    
    //// VerticalLeftTurnRight Drawing
    let verticalLeftTurnRightPath = UIBezierPath()
    verticalLeftTurnRightPath.moveToPoint(CGPointMake(494.5, 871.5))
    verticalLeftTurnRightPath.addLineToPoint(CGPointMake(494.5, 441.5))
    verticalLeftTurnRightPath.addCurveToPoint(CGPointMake(457.5, 406.5), controlPoint1: CGPointMake(494.5, 441.5), controlPoint2: CGPointMake(494.5, 406.5))
    verticalLeftTurnRightPath.addCurveToPoint(CGPointMake(-114.5, 406.5), controlPoint1: CGPointMake(420.5, 406.5), controlPoint2: CGPointMake(-114.5, 406.5))
    verticalLeftTurnRightPath.name = BezierType.Right
    
    
    //// HorizontalLeftStraight Drawing
    let horizontalLeftStraightPath = UIBezierPath()
    horizontalLeftStraightPath.moveToPoint(CGPointMake(-183.5, 362.5))
    horizontalLeftStraightPath.addLineToPoint(CGPointMake(1178.5, 367.5))
    horizontalLeftStraightPath.name = BezierType.Straight
    
    let horizontalRightStraightPath = UIBezierPath()
    horizontalRightStraightPath.moveToPoint(CGPointMake(1114.5, 408.5))
    horizontalRightStraightPath.addLineToPoint(CGPointMake(-114.5, 406.5))
    horizontalRightStraightPath.name = BezierType.Straight
   

    
    
    //// HorizontalRightTurnRight Drawing
    let horizontalRightTurnRightPath = UIBezierPath()
    horizontalRightTurnRightPath.moveToPoint(CGPointMake(1096.5, 409.5))
    horizontalRightTurnRightPath.addLineToPoint(CGPointMake(566.5, 406.5))
    horizontalRightTurnRightPath.addCurveToPoint(CGPointMake(536.5, 441.5), controlPoint1: CGPointMake(566.5, 406.5), controlPoint2: CGPointMake(536.5, 407.5))
    horizontalRightTurnRightPath.addCurveToPoint(CGPointMake(536.5, 870.5), controlPoint1: CGPointMake(536.5, 475.5), controlPoint2: CGPointMake(536.5, 870.5))
    horizontalRightTurnRightPath.name = BezierType.Right
    
    
    //// HorizontalRightTurnLeft Drawing
    let horizontalRightTurnLeftPath = UIBezierPath()
    horizontalRightTurnLeftPath.moveToPoint(CGPointMake(1114.5, 408.5))
    horizontalRightTurnLeftPath.addLineToPoint(CGPointMake(536.5, 407.5))
    horizontalRightTurnLeftPath.addCurveToPoint(CGPointMake(493.5, 365.5), controlPoint1: CGPointMake(536.5, 407.5), controlPoint2: CGPointMake(493.5, 409.5))
    horizontalRightTurnLeftPath.addCurveToPoint(CGPointMake(493.5, -112.5), controlPoint1: CGPointMake(493.5, 321.5), controlPoint2: CGPointMake(493.5, -112.5))
    horizontalRightTurnLeftPath.name = BezierType.Left
    
    
    //// HorizontalLeftTurnLeft Drawing
    let horizontalLeftTurnLeftPath = UIBezierPath()
    horizontalLeftTurnLeftPath.moveToPoint(CGPointMake(-113.5, 363.5))
    horizontalLeftTurnLeftPath.addLineToPoint(CGPointMake(493.5, 364.5))
    horizontalLeftTurnLeftPath.addCurveToPoint(CGPointMake(536.5, 407.5), controlPoint1: CGPointMake(493.5, 364.5), controlPoint2: CGPointMake(536.5, 358.5))
    horizontalLeftTurnLeftPath.addCurveToPoint(CGPointMake(536.5, 911.5), controlPoint1: CGPointMake(536.5, 456.5), controlPoint2: CGPointMake(536.5, 911.5))
    horizontalLeftTurnLeftPath.name = BezierType.Left
    
    
    //// HorizontalLeftTurnRight Drawing
    let horizontalLeftTurnRightPath = UIBezierPath()
    horizontalLeftTurnRightPath.moveToPoint(CGPointMake(-101.5, 364.5))
    horizontalLeftTurnRightPath.addLineToPoint(CGPointMake(457.5, 364.5))
    horizontalLeftTurnRightPath.addCurveToPoint(CGPointMake(493.5, 329.5), controlPoint1: CGPointMake(457.5, 364.5), controlPoint2: CGPointMake(493.5, 364.5))
    horizontalLeftTurnRightPath.addCurveToPoint(CGPointMake(493.5, -88.5), controlPoint1: CGPointMake(493.5, 294.5), controlPoint2: CGPointMake(493.5, -88.5))
    horizontalLeftTurnRightPath.name = BezierType.Right


    return [horizontalLeftStraightPath, horizontalLeftTurnLeftPath, horizontalLeftTurnRightPath, horizontalRightStraightPath, horizontalRightTurnLeftPath, horizontalRightTurnRightPath, verticalLeftStraightPath, verticalLeftTurnLeftPath, verticalLeftTurnRightPath, verticalRightStraightPath, verticalRightTurnLeftPath, verticalRightTurnRightPath]
    
}