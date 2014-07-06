//
//  LoadController.h
//  MultiWebExplorer
//
//  Created by gungor on 11/26/13.
//  Copyright (c) 2013 gungor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadController : UIViewController<NSURLConnectionDelegate>

    @property NSMutableData *responseData;
    @property UIWebView *webView;
    @property UIProgressView *progView;
    @property NSString *mime;
    @property NSString *encoding;
    @property float size;

@end
