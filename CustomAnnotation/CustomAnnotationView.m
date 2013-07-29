//
//  CustomAnnotationView.m
//  CustomAnnotation
//
//  Created by http://Technopote.com on 11/04/13.
//  Copyright (c) 2013 http://Technopote.com. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "Annotation.h"

@implementation CustomAnnotationView

@synthesize calloutView, flightLbl, regLbl, routeLbl, dtLbl , img, flightBtn;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    Annotation *ann = self.annotation;
    if(selected)
    {
        //Add your custom view to self...
        flightLbl = [[UILabel alloc] initWithFrame:CGRectMake(-61, 70, 120, 20)];
        flightLbl.backgroundColor = [UIColor clearColor];
        flightLbl.text = ann.title;
        flightLbl.font=[UIFont boldSystemFontOfSize:12];
        flightLbl.shadowOffset = CGSizeMake(0, 1);
        flightLbl.adjustsFontSizeToFitWidth = YES;

    flightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    flightBtn.frame =CGRectMake(39, 100, 64, 64);
    flightBtn.backgroundColor = [UIColor clearColor];
    [flightBtn addTarget:self action:@selector(flightBtn:) forControlEvents:UIControlEventTouchDown];
    [flightBtn setTitle:ann.fourthtitle forState:UIControlStateDisabled];

        regLbl = [[UILabel alloc] initWithFrame:CGRectMake(-61, 90, 120, 20)];
        regLbl.backgroundColor = [UIColor clearColor];
        regLbl.text = ann.subtitle;
        regLbl.font=[UIFont boldSystemFontOfSize:12];
        regLbl.shadowOffset = CGSizeMake(0, 1);
        regLbl.adjustsFontSizeToFitWidth = YES;


        routeLbl = [[UILabel alloc] initWithFrame:CGRectMake(-61, 110, 120, 20)];
        routeLbl.backgroundColor = [UIColor clearColor];
        routeLbl.text = ann.thirdtitle;
        routeLbl.font=[UIFont boldSystemFontOfSize:12];
        routeLbl.shadowOffset = CGSizeMake(0, 1);
        routeLbl.adjustsFontSizeToFitWidth = YES;


        dtLbl = [[UILabel alloc] initWithFrame:CGRectMake(-61, 130, 120, 20)];
        dtLbl.backgroundColor = [UIColor clearColor];
        dtLbl.text = ann.fourthtitle;
        dtLbl.font=[UIFont boldSystemFontOfSize:12];
        dtLbl.shadowOffset = CGSizeMake(0, 1);
        dtLbl.adjustsFontSizeToFitWidth = YES;
        
        calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"box.png"]];

        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Coffecup.png"]];
        img.frame = CGRectMake(39, 100, 64, 64);
        
/*        if ([ann.locationType isEqualToString:@"airport"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"box.png"]];
        }
        if ([ann.locationType isEqualToString:@"restaurant"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"restaurant.png"]];
        }
        if ([ann.locationType isEqualToString:@"shopping"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopping.png"]];
        }
*/
        [calloutView setFrame:CGRectMake(-71, 18, 0, 0)];
        [calloutView sizeToFit];
        

        flightLbl.textColor = [UIColor whiteColor];
        regLbl.textColor = [UIColor whiteColor];
        routeLbl.textColor = [UIColor whiteColor];
        dtLbl.textColor = [UIColor whiteColor];
        
        [self animateCalloutAppearance];
        [self addSubview:calloutView];
        [self addSubview:flightLbl];
        [self addSubview:regLbl];
        [self addSubview:routeLbl];
        [self addSubview:dtLbl];
        [self addSubview:img];
            [self addSubview:flightBtn];
    }
    else
    {
        //Remove your custom view...
        [calloutView removeFromSuperview];
        [flightLbl removeFromSuperview];
        [regLbl removeFromSuperview];
        [routeLbl removeFromSuperview];
        [dtLbl removeFromSuperview];
        [img removeFromSuperview];
            [flightBtn removeFromSuperview];
    }
}

- (void)didAddSubview:(UIView *)subview{
    Annotation *ann = self.annotation;
    if (![ann.locationType isEqualToString:@"dropped"]) {
        if ([[[subview class] description] isEqualToString:@"UICalloutView"]) {
            for (UIView *subsubView in subview.subviews) {
                if ([subsubView class] == [UIImageView class]) {
                    UIImageView *imageView = ((UIImageView *)subsubView);
                    [imageView removeFromSuperview];
                }else if ([subsubView class] == [UILabel class]) {
                    UILabel *labelView = ((UILabel *)subsubView);
                    [labelView removeFromSuperview];
                }
            }
        }
    }
}

- (void)animateCalloutAppearance {
    CGFloat scale = 0.001f;
    calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    flightLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    regLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    routeLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    dtLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
        flightBtn.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        CGFloat scale = 1.1f;
        calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
        flightLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
        regLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
        routeLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
        dtLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
            flightBtn.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
            CGFloat scale = 0.95;
            calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
            flightLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
            routeLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
            regLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
            dtLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
                flightBtn.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.075 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGFloat scale = 1.0;
                calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
                flightLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
                routeLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
                regLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
                dtLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
                    flightBtn.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
            } completion:nil];
        }];
    }];
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    return YES;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* hitView = [super hitTest:point withEvent:event];
    if (hitView != nil)
        {
        // ensure that the callout appears above all other views
        [self.superview bringSubviewToFront:self];
        
        // we tapped inside the callout
        if (CGRectContainsPoint(flightBtn.frame, point))
            {
            hitView = flightBtn;
            }
        /*        else if (CGRectContainsPoint(self.resultView.addButton.frame, point))
         {
         hitView = self.resultView.addButton;
         }
         else
         {
         hitView = self.resultView.viewDetailsButton;
         }*/
        }
    return hitView;
}

-(void)flightBtn:(UIButton*)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Technopote"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView:self];
}

@end
