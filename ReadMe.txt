### ZoomingPDFJPEGViewer ###
This a very slightly modified version of Apple's sample code "ZoomingPDFViewer".
See original Readme below.

This version intends to do the same thing, but replace the PDF document with a JPEG image.

All Apple's original files have been left intact, except one line in ZoomingPDFViewerViewController.m:

//	PDFScrollView *sv = [[PDFScrollView alloc] initWithFrame:[[self view] bounds]];
JPEGScrollView *sv = [[JPEGScrollView alloc] initWithFrame:[[self view] bounds]];

This branches the application to duplicates of the original Apple's two view classes:

- TiledJPEGView.{h,m} is a modified clone of TiledPDFView.{h,m}
- JPEGSCrollView.{h,m} is a modified clone of PDFSCrollView.{h,m}

The modifications is these cloned classes have been really minimal, only the bare modifications to replace the PDF-specific code
with UIImage equivalent. Even some variable names have been left unchanged even though they clearly relate to a PDF context (e.g. "page").

The UIImage code should work. Indeed, the part of the code that computes are resampled version for the background view works fine.
You can see it briefly while the CATilingLayer redraws the page.

And *that* was broken. The code only painted white rectangle. Also my console filled up with error messages such as:

Sat Mar 26 23:50:28 Prof.local ZoomingJPEGViewer[4415] <Error>: CGContextSetBlendMode: invalid context 0x0
Sat Mar 26 23:50:28 Prof.local ZoomingJPEGViewer[4415] <Error>: CGContextSetAlpha: invalid context 0x0
Sat Mar 26 23:50:28 Prof.local ZoomingJPEGViewer[4415] <Error>: CGContextTranslateCTM: invalid context 0x0
Sat Mar 26 23:50:28 Prof.local ZoomingJPEGViewer[4415] <Error>: CGContextScaleCTM: invalid context 0x0
Sat Mar 26 23:50:28 Prof.local ZoomingJPEGViewer[4415] <Error>: CGContextDrawImage: invalid context 0x0
Sat Mar 26 23:50:28 Prof.local ZoomingJPEGViewer[4415] <Error>: CGContextRestoreGState: invalid context 0x0

Yet, tracing though the code of the drawLayer method reveals a context that was OK, not null.

This is where something was wrong. Here is its full code (from TiledJPEGView.m):

-(void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
  CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
  CGContextFillRect(context,self.bounds);
  CGContextSaveGState(context);
  CGContextScaleCTM(context, myScale,myScale);
  [self->jpegPage drawAtPoint:CGPointZero];  //	instead of CGContextDrawPDFPage(context, pdfPage);
  CGContextRestoreGState(context);
}

The problem is that the current context is not set when drawLayer is called, contrary to drawRect. 
This is why the context to use is passed as an argument.
This problem doesn't arise with PDF because CGContextDrawPDFPage(context, pdfPage) take the context and will internally use it.
So the fix is to call UIGraphicsPushContext(context) at the beginning (and UIGraphicsPopContext() at the end).

-(void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
      CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
      CGContextFillRect(context,self.bounds);
      CGContextSaveGState(context);
      CGContextScaleCTM(context, myScale,myScale);
      [self->jpegPage drawAtPoint:CGPointZero];  //	instead of CGContextDrawPDFPage(context, pdfPage);
      CGContextRestoreGState(context);
    UIGraphicsPopContext();
}


### ZoomingPDFViewer ###

===========================================================================
DESCRIPTION:

This sample demonstrates how to build a PDF viewer that supports zooming in or out at any level of zooming.

The PDF page is rendered into a CATiledLayer so that it uses memory efficiently. ÊWhenever the zoom level changes a new view created at the new size and is drawn on top of the old view, this allows for crisp PDF rendering at large zoom levels.

===========================================================================
BUILD REQUIREMENTS:

Mac OS X v10.6.3 or later; Xcode 3.2.3 or later; iOS 4.0 or later.

===========================================================================
RUNTIME REQUIREMENTS:

Mac OS X v10.6.3 or later; iOS 4.0 or later.

===========================================================================
PACKAGING LIST:

View Controllers
----------------
 
ZoomingPDFViewerViewController.{h,m}
The table view controller responsible for displaying the list of events, supporting additional functionality:
 * Addition of new new events;
 * Deletion of existing events using UITableView's tableView:commitEditingStyle:forRowAtIndexPath: method.
 
Views
----------------
PDFSCrollView.{h,m}
UIScrollView subclass that handles the user input to zoom the PDF page.  This class handles swapping the TiledPDFViews when the zoom level changes.

TiledPDFView.{h,m}
This view is backed by a CATiledLayer into which the PDF page is rendered into.
 
Application configuration
-------------------------
 
ZoomingPDFViewerAppDelegate.{h,m}
Configures the view controller.
 
MainWindow.xib
Loaded automatically by the application. Creates the application's delegate and window.
 
 
===========================================================================
CHANGES FROM PREVIOUS VERSIONS:
 
Version 1.0
- First version.
 
===========================================================================
Copyright (C) 2010 Apple Inc. All rights reserved.
