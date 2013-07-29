//
//  ViewController.m
//  CustomAnnotation
//
//  Created by technopote.com on 18/04/13.
//  Copyright (c) 2013 technopote.com. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "Annotation.h"
#import "CustomAnnotationView.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize _mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading..";
    UILongPressGestureRecognizer *dropPin = [[UILongPressGestureRecognizer alloc] init];
    [dropPin addTarget:self action:@selector(handleLongPress:)];
	dropPin.minimumPressDuration = 0.5;
	[_mapView addGestureRecognizer:dropPin];
    [self setTitle:@"Map View"];
    
    responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://technopote.com/webservices/get_students.php"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];

}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // If it's the user location, just return nil.
    static NSString *identifier = @"CustomPinAnnotationView";
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[Annotation class]]) {
        
        CustomAnnotationView* annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:identifier];
            
            
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            UIImage *img = [UIImage imageNamed:@"pin.png"];
            
//            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:plainColor]];
//            imageView.transform= CGAffineTransformMakeRotation(angle);
//            [annotationView addSubview:imageView];
            annotationView.image=img;
            
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
}


// Add new method above refreshTapped
- (void)plotCrimePositions{
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    for (NSDictionary * row in _flightAr) {
        
        float latitude = [[row objectForKey:@"latitude"] floatValue];
        float longitude = [[row objectForKey:@"longitude"] floatValue];
        NSString * route =[row objectForKey:@"name"];
        NSString *regId =[row objectForKey:@"address"];
        NSString *fltid = [row objectForKey:@"rollno"];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude;
        coordinate.longitude = longitude;
        
        Annotation *ann = [[Annotation alloc] initWithLocation:coordinate];
        [_mapView addAnnotation:ann];
        ann.title = fltid;
        ann.subtitle = regId;
        ann.thirdtitle = route;
        ann.fourthtitle = @"";
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
	if([gestureRecognizer isMemberOfClass:[UILongPressGestureRecognizer class]] && (gestureRecognizer.state == UIGestureRecognizerStateEnded)) {
		[_mapView removeGestureRecognizer:gestureRecognizer]; //avoid multiple pins to appear when holding on the screen
    }
    
    CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
    CLLocationCoordinate2D touchMapCoordinate = [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
	
    Annotation *annotation = [[Annotation alloc]initWithLocation:touchMapCoordinate];
    annotation.title = [NSString stringWithFormat:@"Dropped Pin"];
    annotation.locationType = @"dropped";
    [_mapView addAnnotation:annotation];
    [_mapView selectAnnotation:annotation animated:YES];
    
}
-(IBAction)refreshmap:(id)sender{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Refresh..";
    
    MKCoordinateRegion mapRegion = [_mapView region];
    CLLocationCoordinate2D centerLocation = mapRegion.center;
    
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    _flightAr =[[NSMutableArray alloc ] init];
    responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://technopote.com/webservices/get_students.php"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];    [self setTitle:@"Map View"];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSDictionary *temp = [responseString objectFromJSONString];
    _flightAr = [temp objectForKey:@"students"];
    [self plotCrimePositions];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
