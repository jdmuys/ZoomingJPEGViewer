//
//  JPEGScrollView.h
//  ZoomingPDFViewer
//
//  Created by Jean-Denis Muys on 26/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TiledJPEGView;

@interface JPEGScrollView : UIScrollView <UIScrollViewDelegate> {
    
	// The TiledJPEGView that is currently front most
	TiledJPEGView *pdfView;
	// The old TiledJPEGView that we draw on top of when the zooming stops
	TiledJPEGView *oldPDFView;
	
	// A low res image of the JPEG page that is displayed until the TiledJPEGView
	// renders its content.
	UIImageView *backgroundImageView;
    
    
	// current pdf zoom scale
	CGFloat pdfScale;
	
	UIImage * page;
//	CGPDFDocumentRef pdf;
}

@end
