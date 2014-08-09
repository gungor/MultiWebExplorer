//
//  ViewAdjuster.m
//  MultiWebExplorer
//
//  Created by gungor on 8/7/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import "ViewStateController.h"

@implementation ViewStateController

ViewPosition position;

-(id)init{
    self = [super init];
    position = NORMAL;
    return self;
}

- (void)hide: (UIView *) view
{
    view.hidden = YES;
}

- (void)show: (UIView *) view
{
    view.hidden = NO;
}

- (void) changePosition: (UIView *) translationPanel
{
    if( position == ROTATED )
    {
        translationPanel.bounds = CGRectMake(0, 0, translationPanel.bounds.size.width, translationPanel.bounds.size.height);
        translationPanel.transform = CGAffineTransformMakeRotation(M_PI/2);
    }else{
        translationPanel.bounds = CGRectMake(0, 0, translationPanel.bounds.size.width, translationPanel.bounds.size.height);
        translationPanel.transform = CGAffineTransformMakeRotation(0);
    }
}

- (void)changeToSingleView: (UIButton *) multiplyButton : (UIButton *) hideButton 
{
    multiplyButton.hidden = NO;
    hideButton.hidden = YES;
}

- (void)changeToMultipleView: (UIButton *) multiplyButton : (UIButton *) hideButton
{
    multiplyButton.hidden = YES;
    hideButton.hidden = NO;
}

- (void)rotateClockwise: (UIView *) view : (UIButton *) rotateCW : (UIButton *) rotateCCW
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:1];
    
    view.bounds = CGRectMake(0, 0, view.bounds.size.height, view.bounds.size.width);
    view.transform = CGAffineTransformMakeRotation(M_PI/2);
    rotateCW.hidden = YES;
    rotateCCW.hidden = NO;
    
    position = ROTATED;
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationLandscapeLeft animated:YES];
    [UIView commitAnimations];
}

- (void)rotateCounterClockwise: (UIView *) view : (UIButton *) rotateCW : (UIButton *) rotateCCW
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:1];
    
    view.bounds = CGRectMake(0, 0, view.bounds.size.height, view.bounds.size.width);
    view.transform = CGAffineTransformMakeRotation(0);
    rotateCW.hidden = NO;
    rotateCCW.hidden = YES;
    
    position = NORMAL;
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationPortrait animated:YES];
    [UIView commitAnimations];
}

- (void) adjustComponents: (NSMutableArray *) components
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height-30;
    
    WebViewObject* firstWebObject = [components objectAtIndex:0];
    WebViewObject* secondWebObject = [components objectAtIndex:1];
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.5];
    
    if( firstWebObject.container.hidden == YES && secondWebObject.container.hidden == NO )
    {
        if( [secondWebObject getViewPosition] == NORMAL )
            secondWebObject.container.frame = CGRectMake(30.0f, 30.0f, screenWidth-60, screenHeight-10);
        else
            secondWebObject.container.frame = CGRectMake(30.0f, 30.0f, screenWidth-60, screenHeight-10 );
        [secondWebObject changeToSingleView];
    }
    else if( firstWebObject.container.hidden == NO && secondWebObject.container.hidden == YES )
    {
        if( [firstWebObject getViewPosition] == NORMAL )
            firstWebObject.container.frame = CGRectMake(30.0f, 30.0f, screenWidth-60, screenHeight-10);
        else
            firstWebObject.container.frame = CGRectMake(30.0f, 30.0f, screenWidth-60, screenHeight-10);
        [firstWebObject changeToSingleView];
    }
    
    
    if( firstWebObject.container.hidden == NO && secondWebObject.container.hidden == NO ){
        
        firstWebObject.container.frame = CGRectMake(30.0f, 30.0f, screenWidth-60,screenHeight/2-10);
        secondWebObject.container.frame = CGRectMake(30.0f, screenHeight/2+30,screenWidth-60,screenHeight/2-10);
        
        [firstWebObject changeToMultipleView];
        [secondWebObject changeToMultipleView];
    }
    
    [UIView commitAnimations];
}

- (ViewPosition) getPosition
{
    return position ;
}



@end
