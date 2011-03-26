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
