//
//  ExtendedTextField.m
//  Urtuu
//
//  Created by Mohamed Soussi on 7/21/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

#import "ExtendedTextField.h"

@implementation ExtendedTextField

- (void) drawPlaceholderInRect:(CGRect)rect {
    UIColor *color = [UIColor darkGrayColor];
    
    if ([self.placeholder respondsToSelector:@selector(drawInRect:withAttributes:)]) {
        // iOS 7  and later
        NSDictionary *attributes = @{NSForegroundColorAttributeName: color, NSFontAttributeName: self.font};
        CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
        [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2.0) - boundingRect.size.height/2.0) withAttributes:attributes];
    }
}

@end

