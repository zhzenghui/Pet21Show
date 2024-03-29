//
//  HorizontalTableView.m
//  Horizontal TableView Example
//
//  Created by Diego Rey Mendez on 6/10/12.
//  Copyright (c) 2012 Diego Rey Mendez. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
//  Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
//  AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "HorizontalTableView.h"
#import <QuartzCore/QuartzCore.h>


@implementation HorizontalTableView

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
	
	assert([aDecoder isKindOfClass:[NSCoder class]]);
	
	self = [super initWithCoder:aDecoder];
	
	if (self) {
      self.backgroundColor = [UIColor clearColor];
      self.layer.cornerRadius = 4.0f;;
		const CGFloat k90DegreesCounterClockwiseAngle = (CGFloat) -(90 * M_PI / 180.0);
		
//		CGRect frame = self.frame;
		self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, k90DegreesCounterClockwiseAngle);
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y
                            , 70, 70);
		
	}
	
	assert(self);
	return self;
}

@end
