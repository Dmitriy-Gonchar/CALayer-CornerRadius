//
//  CALayer+CornerRadius.m
//
//  Created by Dmitry on 25.05.18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

#import "CALayer+CornerRadius.h"

@implementation NSBezierPath (BezierPathUtilities)
-(CGPathRef)quartzPath
{
	long numElements;
	CGPathRef           immutablePath = NULL;
	numElements = [self elementCount];
	if(numElements > 0)
	{
		CGMutablePathRef    path = CGPathCreateMutable();
		NSPoint             points[3];
		BOOL                didClosePath = YES;

		for(int i = 0; i < numElements; ++i)
		{
			switch([self elementAtIndex: i associatedPoints: points])
			{
				case NSMoveToBezierPathElement:
					CGPathMoveToPoint(path, NULL, points[0].x, points[0].y);
					break;
				case NSLineToBezierPathElement:
					CGPathAddLineToPoint(path, NULL, points[0].x, points[0].y);
					didClosePath = NO;
					break;
				case NSCurveToBezierPathElement:
					CGPathAddCurveToPoint(path, NULL, points[0].x, points[0].y,
										  points[1].x, points[1].y,
										  points[2].x, points[2].y);
					didClosePath = NO;
					break;
				case NSClosePathBezierPathElement:
					CGPathCloseSubpath(path);
					didClosePath = YES;
					break;
			}
		}
		if(!didClosePath)
			CGPathCloseSubpath(path);
		immutablePath = CGPathCreateCopy(path);
		CGPathRelease(path);
	}
	
	return immutablePath;
}
@end

@implementation CALayer(CornerRadius)
-(void)setCornerRadius: (CGFloat)cornerRadius style: (JCALCR)style
{
	CAShapeLayer *sl = [CAShapeLayer layer];
	NSBezierPath *bp = [NSBezierPath bezierPathWithRoundedRect: self.bounds xRadius: cornerRadius yRadius: cornerRadius];
	CGAffineTransform transform = CGAffineTransformIdentity;

	switch (style)
	{
  		case CALCRBottom:
			transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, cornerRadius);
			break;
		case CALCRLeft:
			transform = CGAffineTransformTranslate(CGAffineTransformIdentity, cornerRadius, 0);
			break;
		case CALCRRight:
			transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -cornerRadius, 0);
			break;
		case CALCRTop:
			transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -cornerRadius);
			break;
	}

	[bp appendBezierPathWithRoundedRect: CGRectApplyAffineTransform(self.bounds, transform) xRadius: 0 yRadius: 0];
	sl.path = bp.quartzPath;

	[self setMask: sl];
}
@end
