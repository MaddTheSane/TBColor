//
//  TBColor.m
//
//  Created by Zoreslav Khimich on 5/26/12.
//  Copyright (c) 2012 Zoreslav Khimich <zoreslav@me.com>
//
//  Licensed under WTFPL http://sam.zoy.org/wtfpl/

#import "TBColor.h"

#if !TARGET_OS_IPHONE
#import <AppKit/AppKit.h>
#endif

@interface TBColor () {
    CGColorRef _CGColor;
    CGColorSpaceRef _CGColorSpace;
}
@end

@implementation TBColor
@synthesize CGColor = _CGColor;

- (instancetype)initWithGenericGray:(CGFloat)gray alpha:(CGFloat)alpha {
    self = [super init];
    if (self) {
#if TARGET_OS_IPHONE
        _CGColorSpace = CGColorSpaceCreateDeviceGray();
        _CGColor = CGColorCreate(_CGColorSpace, (CGFloat[2]){ gray, alpha });
#else
        _CGColor = CGColorCreateGenericGray(gray, alpha);
#endif
    }
    return self;
}

- (instancetype)initWithGenericRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha  {
    self = [super init];
    if (self) {
#if TARGET_OS_IPHONE
        _CGColorSpace = CGColorSpaceCreateDeviceRGB();
        _CGColor = CGColorCreate(_CGColorSpace, (CGFloat[4]){red, green, blue, alpha});
#else
        _CGColor = CGColorCreateGenericRGB(red, green, blue, alpha);
#endif
    }
    return self;
}

static void ImagePatternCallback (void *imagePtr, CGContextRef ctx) {
    CGContextDrawImage(ctx, CGRectMake(0, 0, CGImageGetWidth(imagePtr), CGImageGetHeight(imagePtr)), imagePtr);
}

static void ImageReleaseCallback(void *imagePtr) {
    CGImageRelease(imagePtr);
}

static CGColorRef CGColorMakeFromImage(CGImageRef image) CF_RETURNS_RETAINED;
static CGColorRef CGColorMakeFromImage(CGImageRef image) {
    static const CGPatternCallbacks callback = {0, ImagePatternCallback, ImageReleaseCallback};
    CGPatternRef pattern = CGPatternCreate(image, CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image)), CGAffineTransformIdentity, CGImageGetWidth(image), CGImageGetHeight(image), kCGPatternTilingConstantSpacing, true, &callback);
    CGColorSpaceRef coloredPatternColorSpace = CGColorSpaceCreatePattern(NULL);
    CGFloat dummy = 1.0f;
    CGColorRef color = CGColorCreateWithPattern(coloredPatternColorSpace, pattern, &dummy);
    CGColorSpaceRelease(coloredPatternColorSpace);
    CGPatternRelease(pattern);
    return color;
}

#if !TARGET_OS_IPHONE
- (instancetype)initWithPatternImage:(NSImage *)image {
    self = [super init];
    if (self)
    {
        CGImageRef quartzImage = [image CGImageForProposedRect:NULL context:NULL hints:NULL];
        _CGColor = CGColorMakeFromImage(quartzImage);
        /* quartzImage will be released in ImageReleaseCallback */
    }
    return self;
}

- (instancetype)initWithColor:(NSColor*)color
{
	return [self initWithCGColor:color.CGColor];
}
#endif

- (instancetype)initWithPatternCGImage:(CGImageRef)image {
    self = [super init];
    if (self)
    {
        CGImageRetain(image);
        _CGColor = CGColorMakeFromImage(image);
        /* image will be released in ImageReleaseCallback */
    }
    return self;
}

- (instancetype)initWithCGColor:(CGColorRef)color
{
	if (self = [super init]) {
		_CGColor = CGColorRetain(color);
	}
	return self;
}

- (CGColorSpaceRef)CGColorSpace {
    if (_CGColorSpace == NULL) {
        _CGColorSpace = CGColorGetColorSpace(_CGColor);
        CGColorSpaceRetain(_CGColorSpace);
    }
    return _CGColorSpace;
}

- (void)dealloc {
    CGColorRelease(_CGColor);
    CGColorSpaceRelease(_CGColorSpace);
}

- (CGColorRef)ref {
    return _CGColor;
}

+ (instancetype)colorWithGray:(CGFloat)gray alpha:(CGFloat)alpha {
    return [[TBColor alloc] initWithGenericGray:gray alpha:alpha];
}

+ (instancetype)colorWithGray:(CGFloat)gray {
    return [TBColor colorWithGray:gray alpha:1.f];
}

+ (TBColor *)blackColor {
    static TBColor *blackColor = nil;
    if (!blackColor) {
        blackColor = [TBColor colorWithGray:0.f];
    }
    return blackColor;
}

+ (TBColor *)whiteColor {
    static TBColor *whiteColor = nil;
    if (!whiteColor) {
        whiteColor = [TBColor colorWithGray:1.f];
    }
    return whiteColor;
}

+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [[TBColor alloc] initWithGenericRed:red green:green blue:blue alpha:alpha];
}

+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [TBColor colorWithRed:red green:green blue:blue alpha:1.f];
}


+ (instancetype)colorWithRGB24:(uint32_t)rgb24 alpha:(CGFloat)alpha {
    const unsigned char r8 = (rgb24 & 0x00FF0000) >> 16;
    const unsigned char g8 = (rgb24 & 0x0000FF00) >> 8;
    const unsigned char b8 = (rgb24 & 0x000000FF);
    return [TBColor colorWithRed: (CGFloat)(r8)/255.f green:(CGFloat)(g8)/255.f blue:(CGFloat)(b8)/255.f alpha:(CGFloat)alpha];
}

+ (instancetype)colorWithARGB32:(uint32_t)argb32 {
    const unsigned char a8 = (argb32 & 0xFF000000) >> 24;
    const uint32_t rgb24 = 0xFFFFFF & argb32;
    return [TBColor colorWithRGB24:rgb24 alpha:(CGFloat)(a8)/255.f];
}

+ (instancetype)colorWithRGB24:(uint32_t)rgb24 {
    return [TBColor colorWithARGB32:0xFF000000 | rgb24];
}

#if !TARGET_OS_IPHONE
+ (instancetype)colorWithPattern:(NSImage *)pattern {
    return [[TBColor alloc] initWithPatternImage:pattern];
}

+ (instancetype)colorWithColor:(NSColor*)color {
	return [[TBColor alloc] initWithColor:color];
}
#endif

+ (instancetype)colorWithCGImagePattern:(CGImageRef)pattern {
    return [[TBColor alloc] initWithPatternCGImage:pattern];
}

+ (TBColor *)redColor {
    static TBColor *redColor = nil;
    if (!redColor) {
        redColor = [TBColor colorWithRGB24:0xFF0000];
    }
    return redColor;
}

+ (TBColor *)greenColor {
    static TBColor *greenColor = nil;
    if (!greenColor) {
        greenColor = [TBColor colorWithRGB24:0x00FF00];
    }
    return greenColor;
}

+ (TBColor *)blueColor {
    static TBColor *blueColor = nil;
    if (!blueColor) {
        blueColor = [TBColor colorWithRGB24:0x0000FF];
    }
    return blueColor;
}

+ (TBColor *)clearColor {
    static TBColor *clearColor = nil;
    if (!clearColor) {
        clearColor = [TBColor colorWithGray:0 alpha:0];
    }
    return clearColor;
}

- (void)setFillForContext:(CGContextRef)ctx {
    CGContextSetFillColorWithColor(ctx, self.CGColor);
}

- (void)setStrokeForContext:(CGContextRef)ctx {
    CGContextSetStrokeColorWithColor(ctx, self.CGColor);
}



@end
