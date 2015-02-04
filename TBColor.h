//
//  TBColor.h
//
//  Created by Zoreslav Khimich on 5/26/12.
//  Copyright (c) 2012 Zoreslav Khimich <zoreslav@me.com>
//
//  Licensed under WTFPL http://sam.zoy.org/wtfpl/

#import <Foundation/Foundation.h>

@interface TBColor : NSObject

@property (nonatomic, readonly) CGColorRef CGColor;
- (CGColorRef)CGColor NS_RETURNS_INNER_POINTER;

@property (nonatomic, readonly) CGColorSpaceRef CGColorSpace;
- (CGColorSpaceRef)CGColorSpace NS_RETURNS_INNER_POINTER;

- (CGColorRef)ref NS_RETURNS_INNER_POINTER; // shortcut for CGColor property

- (instancetype)initWithGenericGray:(CGFloat)gray alpha:(CGFloat)alpha;
- (instancetype)initWithGenericRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
#if !TARGET_OS_IPHONE
- (instancetype)initWithPatternImage:(NSImage *)image;
#endif
- (instancetype)initWithPatternCGImage:(CGImageRef)image; /* retains image, you may release it right away */

- (instancetype)initWithCGColor:(CGColorRef)color;

- (void)setFillForContext:(CGContextRef)ctx;
- (void)setStrokeForContext:(CGContextRef)ctx;

+ (instancetype)colorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue Alpha:(CGFloat)alpha;
+ (instancetype)colorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue;

+ (instancetype)colorWithARGB32:(uint32_t)argb32;    // e.g. TBColor *transluentBlue = [TBColor fromARGB32:0x7F00FF00];
+ (instancetype)colorWithRGB24:(uint32_t)rgb24;      // e.g. TBColor *yellow = [TBColor fromRGB24:0xFFFF00];
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
