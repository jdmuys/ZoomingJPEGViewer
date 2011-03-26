//
//  TiledJPEGView.m
//  ZoomingPDFViewer
//
//  Created by Jean-Denis Muys on 26/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TiledJPEGView.h"
#import <QuartzCore/QuartzCore.h>


@implementation TiledJPEGView

// Create a new TiledPDFView with the desired frame and scale.
- (id)initWithFrame:(CGRect)frame andScale:(CGFloat)scale{
    if ((self = [super initWithFrame:frame])) {
		
		CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
		// levelsOfDetail and levelsOfDetailBias determine how
		// the layer is rendered at different zoom levels.  This
		// only matters while the view is zooming, since once the 
		// the view is done zooming a new TiledPDFView is created
		// at the correct size and scale.
        tiledLayer.levelsOfDetail = 4;
		tiledLayer.levelsOfDetailBias = 4;
		tiledLayer.tileSize = CGSizeMake(512.0, 512.0);
		
		myScale = scale;
    }
    return self;
}

// Set the layer's class to be CATiledLayer.
+ (Class)layerClass {
	return [CATiledLayer class];
}

// Set the CGPDFPageRef for the view.
- (void)setPage:(UIImage *)newPage
{
    [self->jpegPage release];
    self->jpegPage = [newPage retain];
}


-(void)drawRect:(CGRect)r
{
    // UIView uses the existence of -drawRect: to determine if it should allow its CALayer
    // to be invalidated, which would then lead to the layer creating a backing store and
    // -drawLayer:inContext: being called.
    // By implementing an empty -drawRect: method, we allow UIKit to continue to implement
    // this logic, while doing our real drawing work inside of -drawLayer:inContext:
}


// Draw the CGPDFPageRef into the layer at the correct scale.
-(void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
	// First fill the background with white.
	CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
    CGContextFillRect(context,self.bounds);
	
	CGContextSaveGState(context);
	// Flip the context so that the PDF page is rendered
	// right side up. (unneeded for UIImage)
	//CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
	//CGContextScaleCTM(context, 1.0, -1.0);
	
	// Scale the context so that the PDF page is rendered 
	// at the correct size for the zoom level.
	CGContextScaleCTM(context, myScale,myScale);
	
    [self->jpegPage drawAtPoint:CGPointZero];
//	CGContextDrawPDFPage(context, pdfPage);
	CGContextRestoreGState(context);
	
}

// Clean up.
- (void)dealloc {
    [self->jpegPage release];
    [super dealloc];
}

@end
