//
//  WebViewObject.h
//  MultiWebExplorer
//
//  Created by gungor on 6/24/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface WebViewObject : UIViewController<AutocompletionTableViewDelegate,UIGestureRecognizerDelegate>

typedef enum viewPositions
{
    NORMAL,
    ROTATED
} ViewPosition;


@property (weak, nonatomic) ViewController *mainController;

@property (weak, nonatomic) UIView *container;
@property (weak, nonatomic) UIWebView *webView;
@property (weak, nonatomic) UITextField *textField;
@property (weak, nonatomic) UIButton *goButton;
@property (weak, nonatomic) UIButton *backButton;
@property (weak, nonatomic) UIButton *forwardButton;
@property (weak, nonatomic) UIProgressView *progress;
@property (weak, nonatomic) UIButton *rotateButtonCW;
@property (weak, nonatomic) UIButton *rotateButtonCCW;
@property (weak, nonatomic) UIButton *hideButton;
@property (weak, nonatomic) UIButton *multiplyButton;

@property (weak, nonatomic) AutocompletionTableView *autoCompleter;

-(id)initComponent:(ViewController *) controller:(float) x:(float) y:(float) width:(float) height;
-(void)closeSuggestions;
-(void)changePosition: (UIView *) translationPanel;
-(UIView *) getView;
-(Boolean) isOwnerOfWebView: (UIWebView *) webView;
- (void)hide;
- (void)show;
- (void)changeToSingleView;
- (void)changeToMultipleView;

@end
