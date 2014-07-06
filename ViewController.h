//
//  ViewController.h
//  MultiWebExplorer
//
//  Created by gungor on 11/6/13.
//  Copyright (c) 2013 gungor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AutocompletionTableView.h"
#import "GoogleTranslator.h"


@protocol AutocompletionTableViewDelegate;

@interface ViewController : UIViewController<AutocompletionTableViewDelegate,UIGestureRecognizerDelegate>


@property (strong, nonatomic) NSMutableArray *components;
@property (strong, nonatomic) IBOutlet UIView *mainContainer;


@property (weak, nonatomic) IBOutlet UIView *translationPopup;


@end
