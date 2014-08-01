//
//  TranslationController.h
//  MultiWebExplorer
//
//  Created by gungor on 7/1/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "WebViewObject.h"

@interface TranslationController : UIViewController

@property (strong, nonatomic) UIView *translationPanel;
@property (strong, nonatomic) WebViewObject *src;
@property (strong, nonatomic) UITextView *textarea;


-(id) initComponents: (float) x : (float) y ;
-(UIView *) getView;
-(void)setSource: (WebViewObject *)src;
-(void)translate;
-(void)showTranslation:  (NSString *) sourceString;
+(TranslationController* )instance;
-(void)hide;

@end
