//
//  CALayer+CornerRadius.h
//
//  Created by Dmitry on 25.05.18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSUInteger, CALCR) {
	CALCRBottom = 0,
	CALCRTop = 1,
	CALCRLeft = 2,
	CALCRRight = 3
};

@interface CALayer(CornerRadius)
-(void)setCornerRadius:(CGFloat)cornerRadius style: (CALCR) style;
@end
