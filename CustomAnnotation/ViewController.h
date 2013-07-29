//
//  ViewController.h
//  CustomAnnotation
//
//  Created by technopote.com on 18/04/13.
//  Copyright (c) 2013 technopote.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@class Annotation;

@interface ViewController : UIViewController<NSXMLParserDelegate,MKMapViewDelegate, UIActionSheetDelegate,UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>{

    UIImageView *imageView;
    UITableView *tableView;
    UIPopoverController *popover;
    NSMutableArray *plainAr;
    NSMutableData *responseData;
}
@property (nonatomic, retain) NSMutableArray *flightAr;
@property (strong, nonatomic) IBOutlet MKMapView *_mapView;//This was auto-added by Xcode :]
-(IBAction)refreshmap:(id)sender;

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer;

@end
