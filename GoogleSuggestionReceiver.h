//
//  SuggestionReceiver.h
//  MultiWebExplorer
//
//  Created by gungor on 3/2/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AutocompletionTableView.h"
#import "AFHTTPRequestOperationManager.h"

@interface GoogleSuggestionReceiver : NSObject

+ (void)suggest:(NSString* )searchString : (AutocompletionTableView*) autocompleteView;

+ (void)loadBySearch: (NSString *)searchString : (UIWebView *) webView;

@end
