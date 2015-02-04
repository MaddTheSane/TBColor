//
//  TBColor.h
//
//  Created by Zoreslav Khimich on 5/26/12.
//  Copyright (c) 2012 Zoreslav Khimich <zoreslav@me.com>
//
//  Licensed under WTFPL http://sam.zoy.org/wtfpl/

#import <Foundation/Foundation.h>
#include <CoreGraphics/CoreGraphics.h>

#if !TARGET_OS_IPHONE
@class NSImage;
#endif

@interface TBColor : NSObject

@property (nonatomic, readonly) CGColorRef CGColor NS_RETURNS_INNER_POINTER;
@property (nonatomic, readonly) CGColorSpaceRef CGColorSpace NS_RETURNS_INNER_POINTER;

//* shortcut for CGColor property
- (CGColorRef)ref NS_RETURNS_INNER_POINTER;

- (instancetype)initWithGenericGray:(CGFloat)gray alpha:(CGFloat)alpha;
- (instancetype)initWithGenericRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
#if !TARGET_OS_IPHONE
- (instancetype)initWithPatternImage:(NSImage *)image;
#endif
/** retains image, you may release it right away */
- (instancetype)initWithPatternCGImage:(CGImageRef)image;

- (instancetype)initWithCGColor:(CGColorRef)color;

- (void)setFillForContext:(CGContextRef)ctx;
- (void)setStrokeForContext:(CGContextRef)ctx;

+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

//* e.g. TBColor *transluentBlue = [TBColor fromARGB32:0x7F00FF00];
+ (instancetype)colorWithARGB32:(uint32_t)argb32;
//* e.g. TBColor *yellow = [TBColor fromRGB24:0xFFFF00];
+ (instancetype)colorWithRGB24:(uint32_t)rgb24;
+ (instancetype)colorWithRGB24:(uint32_t)rgb24 alpha:(CGFloat)alpha;


+ (instancetype)colorWithGray:(CGFloat)gray alpha:(CGFloat)alpha;
+ (instancetype)colorWithGray:(CGFloat)gray;

#if !TARGET_OS_IPHONE
+ (instancetype)colorWithPattern:(NSImage *)pattern;
#endif
+ (instancetype)colorWithCGImagePattern:(CGImageRef)pattern;

+ (TBColor *)blackColor;
+ (TBColor *)whiteColor;
+ (TBColor *)redColor;
+ (TBColor *)greenColor;
+ (TBColor *)blueColor;
+ (TBColor *)clearColor;

@end
