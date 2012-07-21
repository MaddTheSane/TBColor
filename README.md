TBColor
=======

`TBColor` is an ARC-compatible `CGColor`/`CGColorRef` wrapper class. It holds a `CGColorRef` and releases it when deallocated, that's it.

iOS developers have `UIColor` which does the same thing. `TBColor` is supposed to partially substitute `UIColor` on OS X (until Apple provides something better).

There are some convenience constructors, see below.

Life Span
---------

Underlying CGColorRef lives no longer then it's owning TBColor instance. Doing this would be a bad idea:

    CGColorRef makeMeAColor() {
        TBColor *willProbablyDieSoon = [TBColor fromRGB24:0x336699].CGColor;
        return willProbablyDieSoon.CGColor; // WRONG!
    }

If you absolutely must pass colors around, pass a TBColor instance instead:

    TBColor *makeMeAColor() {
        return [TBColor fromRGB24:0x336699]; // Okay.
    }

    ...

    CALayer *coloredLayer = [CALayer *layer];
    coloredLayer.backgroundColor = makeMeAColor().CGColor;


Usage
-----

`TBColor`'s `CGColor` is a read-only property. It contains `CGColorRef` for the color.

### Construction

Generic RGB from CGFloats:

    TBColor *theColor = [TBColor R:0.3f G:0.5f B:.12f];
    CGContextSetFillColorWithColor(ctx, theColor.CGColor);

or

    CGContextSetFillColorWithColor(ctx, [TBColor R:0.3 G:0.5 B:.12].CGColor);

Generic gray:

    TBColor *theColor = [TBColor gray:0.35];

RGB and gray with alpha: 
    
    TBColor *semiYellow = [TBColor R:1.0 G:0.8 B:0.0 A:0.45];
    TBColor *semiGray = [TBColor gray:0.8 alpha:0.4];

24-bit RGB:

    TBColor *twitterColor = [TBColor fromRGB24:0x9AE4E8]; // http://www.colourlovers.com/color/9AE4E8/twitter

32-bit ARGB:

    TBColor *semiTransparentPurple = [TBColor fromARGB32:0x7FEE00FF];

Predefined colors:
    
    textLayer.backgroundColor = [TBColor white].CGColor;
    consoleLayer.backgroundColor = [TBColor black].CGColor;
    redLayer.backgroundColor = [TBColor red].CGColor;
    greenLayer.backgroundColor = [TBColor green].CGColor;
    blueLayer.backgroundColor = [TBColor blue].CGColor;

License
-------

Do [what the fuck you want to][WTFPL].

[WTFPL]: http://sam.zoy.org/wtfpl/
