//
//  CustomAnnotationView.h
//  CustomAnnotation
//
//  Created by http://Technopote.com on 11/04/13.
//  Copyright (c) 2013 http://Technopote.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotationView : MKAnnotationView

@property (strong, nonatomic) UIImageView *calloutView;
@property (strong, nonatomic) UIImageView *img;
@property (strong, nonatomic) UILabel *flightLbl;
@property (strong, nonatomic) UILabel *regLbl;
@property (strong, nonatomic) UILabel *routeLbl;
@property (strong, nonatomic) UILabel *dtLbl;
@property (strong, nonatomic) UIButton *flightBtn;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)animateCalloutAppearance;

@end