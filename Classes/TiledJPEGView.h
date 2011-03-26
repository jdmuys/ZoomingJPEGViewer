//
//  TiledJPEGView.h
//  ZoomingPDFViewer
//
//  Created by Jean-Denis Muys on 26/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TiledJPEGView : UIView {
    
	UIImage * jpegPage;
	CGFloat myScale;
}

- (id)initWithFrame:(CGRect)frame andScale:(CGFloat)scale;
- (void)setPage:(UIImage *)newPage;

@end
