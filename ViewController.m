//
//  ViewController.m
//  MultiWebExplorer
//
//  Created by gungor on 11/6/13.
//  Copyright (c) 2013 gungor. All rights reserved.
//

#import "ViewController.h"
#import "LoadController.h"
#import "WebViewObject.h"
#import "TranslationController.h"



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = self.mainContainer;
    [self.mainContainer setBackgroundColor:[UIColor whiteColor]];
    [self.mainContainer setTintColor:[UIColor whiteColor]];
    
    self.components = [[NSMutableArray alloc] init];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height-30;
    
    //Initially two webview controllers are created. For two components given size parameters are suitable for all devices.
    WebViewObject *webviewObject = [[[WebViewObject alloc] init] initComponent: self: 30.0f:30.0f:screenWidth-60:screenHeight/2-10];
    WebViewObject *webviewObject2 = [[[WebViewObject alloc] init] initComponent: self: 30.0f:screenHeight/2+30:screenWidth-60:screenHeight/2-10];
    
    [self addChildViewController:webviewObject];
    [self addChildViewController:webviewObject2];
    [self.mainContainer addSubview:[webviewObject getView]];
    [self.mainContainer addSubview:[webviewObject2 getView]];
    [self.components addObject:webviewObject];
    [self.components addObject:webviewObject2];
    
    TranslationController *translationController = [[TranslationController alloc] initComponents: screenWidth/2-200 : screenHeight/2-200+30 ];
    [self addChildViewController:translationController];
    [self.mainContainer addSubview:[translationController getView]];
    
    UITapGestureRecognizer *tapRcgnzr = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(respondToTapGesture:)];
    tapRcgnzr.delegate = self;
    [self.mainContainer addGestureRecognizer:tapRcgnzr];
    
        
    UIMenuItem *translateAction = [[UIMenuItem alloc]initWithTitle:@"Translate" action:@selector(translate:)];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    menu.menuItems = [NSArray arrayWithObject:translateAction];
    [menu update];
    
    NSLog(@" DIDLOAD %u %u ", webviewObject.container.hidden, webviewObject.container.hidden );
}

//Runs when menu appears
- (void) onShowMenu: (UIGestureRecognizer*) sender
{
    if( sender.state == UIGestureRecognizerStateEnded )
    {
        WebViewObject* sourceWebViewObject = nil;
        for (WebViewObject* obj in self.components) {
            if( [obj isOwnerOfWebView:sender.view] )
            {
                sourceWebViewObject = obj;
                break;
            }
        }
        [[TranslationController instance] setSource:sourceWebViewObject];
        [sender.view becomeFirstResponder];
        UIMenuController* mc = [UIMenuController sharedMenuController];
        [mc setTargetRect: sender.view.frame inView: sender.view.superview];
        [mc setMenuVisible: YES animated: YES];
    }
}

- (void) translate: (UIGestureRecognizer*) sender
{
    [[TranslationController instance] translate];
}

//When screen is tapped, all suggestion box need to be closed
- (IBAction)respondToTapGesture:(UITapGestureRecognizer *)recognizer {
    [[TranslationController instance] hide];
    for(int i=0; i<[self.components count] ; i++ )
    {
        [((WebViewObject*)[self.components objectAtIndex:i]) closeSuggestions];
    }
}

- (IBAction)hide:(UIButton *)sender {
    WebViewObject* sourceWebViewObject = nil;
    for (WebViewObject* obj in self.components) {
        if( [obj isOwnerOfWebView:sender] )
        {
            sourceWebViewObject = obj;
            break;
        }
    }
    
    [sourceWebViewObject hide];
    [self adjustComponents];
}

- (IBAction)show:(UIButton *)sender {
    WebViewObject* sourceWebViewObject = nil;
    for (WebViewObject* obj in self.components) {
        if( ![obj isOwnerOfWebView:sender] )
        {
            sourceWebViewObject = obj;
            break;
        }
    }
    
    NSLog(@"show view controller");
    NSLog(@" %@ ", sourceWebViewObject );
    
    [sourceWebViewObject show];
    [self adjustComponents];
}

- (void) adjustComponents
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height-30;
    
    WebViewObject* firstWebObject = [self.components objectAtIndex:0];
    WebViewObject* secondWebObject = [self.components objectAtIndex:1];
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.5];
    
    if( firstWebObject.container.hidden == YES && secondWebObject.container.hidden == NO )
    {
        secondWebObject.container.frame = CGRectMake(30.0f, 30.0f, secondWebObject.container.bounds.size.width, screenHeight-10);
        [secondWebObject changeToSingleView];
    }
    else if( firstWebObject.container.hidden == NO && secondWebObject.container.hidden == YES )
    {
        firstWebObject.container.frame = CGRectMake(30.0f, 30.0f, firstWebObject.container.bounds.size.width, screenHeight-10);
        [firstWebObject changeToSingleView];
    }
    
    NSLog(@" %u %u ", firstWebObject.container.hidden, secondWebObject.container.hidden );
    
    if( firstWebObject.container.hidden == NO && secondWebObject.container.hidden == NO ){
        
        firstWebObject.container.frame = CGRectMake(30.0f, 30.0f, screenWidth-60,screenHeight/2-10);
        secondWebObject.container.frame = CGRectMake(30.0f, screenHeight/2+30,screenWidth-60,screenHeight/2-10);
        
        [firstWebObject changeToMultipleView];
        [secondWebObject changeToMultipleView];
    }
    
    [UIView commitAnimations];
}

//Overriding 'shouldReceiveTouch' is required when different actions are taken according to the tapped component.
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    for(int i=0; i<[self.components count] ; i++ )
    {
        if ([touch.view isDescendantOfView:((WebViewObject*)[self.components objectAtIndex:i]).autoCompleter]) {
            return NO;
        }
    }
    
    if( [touch.view isDescendantOfView: [[TranslationController instance] getView] ])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


@end
