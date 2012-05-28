//
//  TBColor.m
//
//  Created by Zoreslav Khimich on 5/26/12.
//  Copyright (c) 2012 Zoreslav Khimich <zoreslav@me.com>
//
//  Licensed under WTFPL (http://sam.zoy.org/wtfpl/)

#import "TBColor.h"
@interface TBColor () {
    CGColorRef cgColor_;
}
@end

@implementation TBColor

- (id)initWithGenericGray:(CGFloat)gray alpha:(CGFloat)alpha {
    self = [super init];
    if (self)
    {
        cgColor_ = CGColorCreateGenericGray(gray, alpha);
    }
    return self;
}

- (void)dealloc {
    CGColorRelease(cgColor_);
}

- (CGColorRef)ref {
    return cgColor_;
}

+ (TBColor*)gray:(CGFloat)gray alpha:(CGFloat)alpha {
    return [[TBColor alloc] initWithGenericGray:gray alpha:alpha];
}

+ (TBColor*)gray:(CGFloat)gray {
    return [TBColor gray:gray alpha:1.0];
}

+ (TBColor*)black {
    return [TBColor gray:0.];
}

+ (TBColor*)white {
    return [TBColor gray:1.];
}

@end
