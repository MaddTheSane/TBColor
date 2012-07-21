//
//  TBColor.h
//
//  Created by Zoreslav Khimich on 5/26/12.
//  Copyright (c) 2012 Zoreslav Khimich <zoreslav@me.com>
//
//  Licensed under WTFPL (http://sam.zoy.org/wtfpl/)

#import <Foundation/Foundation.h>

@interface TBColor : NSObject

@property(nonatomic, readonly) CGColorRef CGColor;
- (CGColorRef)ref; // shortcut for CGColor property

- (id)initWithGenericGray:(CGFloat)gray alpha:(CGFloat)alpha;
- (id)initWithGenericRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (TBColor *)R:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;
+ (TBColor *)R:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue;

+ (TBColor *)fromARGB32:(uint32_t)argb32;    // e.g. TBColor *transluentBlue = [TBColor fromARGB32:0x7F00FF00];
+ (TBColor *)fromRGB24:(uint32_t)rgb24;      // e.g. TBColor *yellow = [TBColor fromRGB24:0xFFFF00];

+ (TBColor *)gray:(CGFloat)gray alpha:(CGFloat)alpha;
+ (TBColor *)gray:(CGFloat)gray;
+ (TBColor *)black;
+ (TBColor *)white;

+ (TBColor *)red;
+ (TBColor *)green;
+ (TBColor *)blue;

@end
