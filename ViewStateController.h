//
//  ViewAdjuster.h
//  MultiWebExplorer
//
//  Created by gungor on 8/7/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewObject.h"
#import "ViewPosition.h"


@interface ViewStateController : NSObject



- (id)init;
- (void)rotateClockwise;
- (void)rotateCounterClockwise;
- (void)hide: (UIView *) view;
- (void)show: (UIView *) view;
- (void) changePosition: (UIView *) translationPanel;
- (void)changeToSingleView: (UIButton *) multiplyButton : (UIButton *) hideButton ;
- (void)changeToMultipleView: (UIButton *) multiplyButton : (UIButton *) hideButton;
- (void)rotateClockwise: (UIView *) view : (UIButton *) rotateCW : (UIButton *) rotateCCW ;
- (void)rotateCounterClockwise: (UIView *) view : (UIButton *) rotateCW : (UIButton *) rotateCCW ;
- (void) adjustComponents: (NSMutableArray *) components  ;
- (ViewPosition) getPosition;

@end
