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

-(id)initComponent:(ViewController *) controller:(float) x:(float) y:(float) width:(float) height;

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

@property (weak, nonatomic) AutocompletionTableView *autoCompleter;

- (void)closeSuggestions;
-(UIView *) getView;

@end
