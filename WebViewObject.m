//
//  WebViewObject.m
//  MultiWebExplorer
//
//  Created by gungor on 6/24/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import "WebViewObject.h"
#import "LoadController.h"
#import "TranslationController.h"
#import "Utility.h"

@implementation WebViewObject

ViewPosition position;

-(id)initComponent:(ViewController *) controller :(float) x:(float) y:(float) width:(float) height
{
    self.mainController = controller;
    [self addComponents:x :y :width :height];
    [self attachActions];
    return self;
}

-(void)addComponents :(float) x:(float) y:(float) width:(float) height{
    
    
    UIView *vw = [[UIView alloc] initWithFrame:CGRectMake(x,y, width, height)  ];
    [[vw layer] setBorderColor:[[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] CGColor]];
    [[vw layer] setBorderWidth:1];
    [vw setBackgroundColor:[UIColor whiteColor]];

    [vw setTintColor:[UIColor blackColor]];
    self.container = vw;
    self.view = vw;
    
    UIWebView *webView =  [[UIWebView alloc] initWithFrame:CGRectMake(0, 30, width, height-30) ];
    [[webView layer] setBorderColor:
     [[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] CGColor]];
    [[webView layer] setBorderWidth:1];
    [webView setBackgroundColor:[UIColor clearColor]];
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
    webView.opaque = NO;
    webView.delegate = self;
    
    self.webView = webView;
    [vw addSubview:webView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width - 220 , 31) ];
    [[textField layer] setBorderColor:
     [[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] CGColor]];
    [[textField layer] setBorderWidth:1];
    textField.autoresizingMask = (UIViewAutoresizingFlexibleWidth );
    textField.layer.zPosition = 2.0f;
    self.textField = textField;
    [vw addSubview:textField];
    
    self.autoCompleter = [[AutocompletionTableView alloc] initWithTextField:self.textField  :self.container : self.webView ] ;
    [self.textField addTarget:self.autoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *goButton = [[UIButton alloc] initWithFrame:CGRectMake(textField.bounds.size.width , 0, 30 , 30) ];
    [goButton setTitle:@"Go" forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goButton.layer.backgroundColor = [[UIColor colorWithRed:0.0f green:122.0f/255.0f blue:1.0f alpha:1.0f ] CGColor];
    goButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.goButton = goButton;
    [vw addSubview:goButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(textField.bounds.size.width + goButton.bounds.size.width + 20  , 0, 22 , 30) ];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.backButton = backButton;
    [vw addSubview:backButton];
    
    UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(textField.bounds.size.width + goButton.bounds.size.width + backButton.bounds.size.width + 40, 0, 22 , 30) ];
    [forwardButton setBackgroundImage:[UIImage imageNamed:@"forward.png"] forState:UIControlStateNormal];
    forwardButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.forwardButton = forwardButton;
    [vw addSubview:forwardButton];
    
    
    UIButton *rotateButtonCW = [[UIButton alloc] initWithFrame:CGRectMake(textField.bounds.size.width + goButton.bounds.size.width + backButton.bounds.size.width + forwardButton.bounds.size.width + 60, 0, 30 , 30) ];
    [rotateButtonCW setBackgroundImage:[UIImage imageNamed:@"rotate1.png"] forState:UIControlStateNormal];
    rotateButtonCW.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.rotateButtonCW = rotateButtonCW;
    
    [vw addSubview:rotateButtonCW];
    
    UIButton *rotateButtonCCW = [[UIButton alloc] initWithFrame:CGRectMake(textField.bounds.size.width + goButton.bounds.size.width + backButton.bounds.size.width + forwardButton.bounds.size.width + 60, 0, 30 , 30) ];
    [rotateButtonCCW setBackgroundImage:[UIImage imageNamed:@"rotate2.png"] forState:UIControlStateNormal];
    rotateButtonCCW.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.rotateButtonCCW = rotateButtonCCW;
    rotateButtonCCW.hidden = YES;
    [vw addSubview:rotateButtonCCW];
    
    UIButton *hideButton = [[UIButton alloc] initWithFrame:CGRectMake(textField.bounds.size.width + goButton.bounds.size.width + backButton.bounds.size.width + forwardButton.bounds.size.width + rotateButtonCW.bounds.size.width + 80, 0, 30 , 30) ];
    [hideButton setBackgroundImage:[UIImage imageNamed:@"hide.png"] forState:UIControlStateNormal];
    [hideButton setBackgroundColor:[UIColor whiteColor]];
    hideButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.hideButton = hideButton;
    [vw addSubview:hideButton];
    
    
    UIButton *multiplyButton = [[UIButton alloc] initWithFrame:CGRectMake(textField.bounds.size.width + goButton.bounds.size.width + backButton.bounds.size.width + forwardButton.bounds.size.width + rotateButtonCW.bounds.size.width + 80, 0, 30 , 30) ];
    [multiplyButton setBackgroundImage:[UIImage imageNamed:@"multiply.png"] forState:UIControlStateNormal];
    [multiplyButton setBackgroundColor:[UIColor whiteColor]];
    multiplyButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.multiplyButton = multiplyButton;
    multiplyButton.hidden = YES;
    [vw addSubview:multiplyButton];
    
    position = NORMAL;
}

-(void)attachActions{
    [self.rotateButtonCW addTarget:self action:@selector(rotateClockwise:)forControlEvents:UIControlEventTouchUpInside];
    [self.rotateButtonCCW addTarget:self action:@selector(rotateCounterClockwise:)forControlEvents:UIControlEventTouchUpInside];
    [self.goButton addTarget:self action:@selector(loadUrl:)forControlEvents:UIControlEventTouchUpInside];
    [self.textField addTarget:self action:@selector(textTouched:)forControlEvents:UIControlEventTouchDown];
    
    
    [self.backButton addTarget:self action:@selector(back:)forControlEvents:UIControlEventTouchUpInside];
    [self.forwardButton addTarget:self action:@selector(forward:)forControlEvents:UIControlEventTouchUpInside];
    [self.hideButton addTarget:self.mainController action:@selector(hide:)forControlEvents:UIControlEventTouchUpInside];
    [self.multiplyButton addTarget:self.mainController action:@selector(show:)forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer* gr = [ [UILongPressGestureRecognizer alloc] initWithTarget: self.mainController action: @selector( onShowMenu: ) ];
    gr.delegate = self.mainController;
    [self.webView addGestureRecognizer: gr];

}

- (IBAction)rotateClockwise:(UIButton *)sender {
    
    position = ROTATED;
    
    [self.view endEditing:YES];
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:1];
    
    self.container.bounds = CGRectMake(0, 0, self.container.bounds.size.height, self.container.bounds.size.width);
    self.container.transform = CGAffineTransformMakeRotation(M_PI/2);
    self.rotateButtonCW.hidden = YES;
    self.rotateButtonCCW.hidden = NO;
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationLandscapeLeft animated:YES];
    [UIView commitAnimations];
}

- (IBAction)rotateCounterClockwise:(UIButton *)sender {
    
    position = NORMAL;
    
    [self.view endEditing:YES];
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:1];
    
    self.container.bounds = CGRectMake(0, 0, self.container.bounds.size.height, self.container.bounds.size.width);
    self.container.transform = CGAffineTransformMakeRotation(0);
    self.rotateButtonCW.hidden = NO;
    self.rotateButtonCCW.hidden = YES;
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationPortrait animated:YES];
    [UIView commitAnimations];
}

- (void)hide
{
    self.container.hidden = YES;
}

- (void)show
{
    NSLog(@" Show Run.. ");
    self.container.hidden = NO;
}

- (IBAction)loadUrl:(id)sender {
    [self load: [Utility checkUrl:self.textField.text]  : self.webView : self.progress];
}

-(void)load: (NSString *)theString : (UIWebView *)webView : (UIProgressView *)progressView {
    [self closeSuggestions];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:theString]];
    [webView loadRequest:req];
    
}

- (void)closeSuggestions{
    [self.autoCompleter hideOptionsView];
}

- (IBAction)back:(id)sender {
    if( [self.webView canGoBack] )
        [self.webView goBack];
}

- (IBAction)forward:(id)sender {
    if( [self.webView canGoForward] )
        [self.webView goForward];
}

- (IBAction)textTouched:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)tapScreen:(id)sender {
    [self closeSuggestions];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

// This function is called on all location change :
- (BOOL)webView:(UIWebView *)webView2 shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // Intercept custom location change, URL begins with "js-call:"
    if ([[[request URL] absoluteString] hasPrefix:@"js-call:"]) {
        NSArray *components = [[[request URL] absoluteString] componentsSeparatedByString:@":"];
        NSString *function = [components objectAtIndex:1];
        
        NSString *sourceString = [function stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[TranslationController instance] showTranslation:sourceString];
        
        return NO;
    }
    
    // Accept this location change
    return YES;
    
}

-(UIView *) getView
{
    return self.container;
}

-(Boolean) isOwnerOfWebView: (id) child
{
    if( [child class] == [UIWebView class] )
    {
        return self.webView == child;
    }
    
    if( [child class] == [UIButton class] )
    {
        if( self.hideButton == child )
        {
            return true;
        }
        
        if( self.multiplyButton == child )
        {
            return true;
        }
    }
    
    return false;
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

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@" Load F,nished ");
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@" Load Started ");
}

- (void)changeToSingleView {
    self.multiplyButton.hidden = NO;
    self.hideButton.hidden = YES;
}

- (void)changeToMultipleView {
    self.multiplyButton.hidden = YES;
    self.hideButton.hidden = NO;
}

@end
