//
//  LoadController.m
//  MultiWebExplorer
//
//  Created by gungor on 11/26/13.
//  Copyright (c) 2013 gungor. All rights reserved.
//

#import "LoadController.h"

@interface LoadController ()

@end

@implementation LoadController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@" Memory Warning ");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    
    _size = [response expectedContentLength];
    self.progView.hidden = false;
    
    NSLog(@" Receive Response ");
    _mime = [response MIMEType];
    _responseData = [[NSMutableData alloc] init];
    _encoding = [ response textEncodingName ];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"Receive Data");
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    float progressive = (float)[_responseData length] / (float)self.size;
    
    //[progress setProgress:progressive];
    
    
    self.progView.progress = progressive;
    
    NSLog(@" %f " , progressive);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response *for this connection

    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSLog(@"Finish");
    
    self.progView.hidden = true;
     
    
    [_webView loadData:_responseData MIMEType:self.mime textEncodingName:self.encoding baseURL:nil];
    
    //NSString *msStr = [@"document.characterSet='" stringByAppendingString: @"ISO-8859-1"  ];
    //msStr = [ msStr stringByAppendingString: @"';" ];
    //[_webView stringByEvaluatingJavaScriptFromString: msStr];

    //NSString *jsCode =  @ "var meta = document.createElement('meta');meta.httpEquiv = 'Content-Type'; meta.content = 'text/html; charset=utf-8'; document.getElementsByTagName('head')[0].appendChild(meta); ";
    
    //[_webView stringByEvaluatingJavaScriptFromString: jsCode];
  
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"Fail");
    
}


@end
