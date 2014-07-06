//
//  SuggestionReceiver.m
//  MultiWebExplorer
//
//  Created by gungor on 3/2/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import "GoogleSuggestionReceiver.h"


@implementation GoogleSuggestionReceiver

+ (void)suggest:(NSString* )searchString: (AutocompletionTableView* ) autocompleteView
{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/complete/search?output=firefox&q=%@", [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        autocompleteView.suggestionsDictionary = [NSMutableArray array];
        
        for (id value in [responseObject objectAtIndex:1]) {
            [ autocompleteView.suggestionsDictionary addObject:value ];
        }
        
        [autocompleteView checkView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
}

+ (void)loadBySearch: (NSString *)searchString : (UIWebView *) webView
{
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com?q=%@#q=%@", [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]];
    
    [webView loadRequest:req];
}


@end
