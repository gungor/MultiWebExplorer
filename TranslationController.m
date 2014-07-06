//
//  TranslationController.m
//  MultiWebExplorer
//
//  Created by gungor on 7/1/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import "TranslationController.h"
#import "ViewController.h"

@implementation TranslationController

static TranslationController *instance;

-(id) initComponents: (float) x : (float) y
{
    UIView* translationPanel = [[UIView alloc] initWithFrame:CGRectMake(x,y, 400, 400) ];
    [[translationPanel layer] setBorderColor:[[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] CGColor]];
    [[translationPanel layer] setBorderWidth:1];
    [translationPanel setBackgroundColor:[UIColor whiteColor]];
    translationPanel.hidden = YES;
    self.translationPanel = translationPanel;
    instance = self;
    return self;
}

-(UIView *) getView
{
    return self.translationPanel;
}

-(void)setSource: (UIWebView *)src
{
    self.src = src;
}

-(void)translate
{
    NSString *jsFunctionText = @" var text = window.getSelection(); var iframe = document.createElement('IFRAME'); iframe.setAttribute('src', 'js-call:'+text);   document.documentElement.appendChild(iframe); iframe.parentNode.removeChild(iframe); iframe = null;  ";
    [self.src stringByEvaluatingJavaScriptFromString:jsFunctionText];
}

-(void)showTranslation:  (NSString *) sourceString;
{
    [self clearTranslation];
    
    UIFont *font = [UIFont fontWithName: @"Arial" size: 16.0f];
    
    NSString *translationString = [ GoogleTranslator translate:sourceString];
    
    CGRect sourceContainerRect = [self calculateContainerBounds:sourceString :font];
    UITextView *sourceLabel = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 360, sourceContainerRect.size.height+10)];
    
    CGRect translationContainerRect = [self calculateContainerBounds:translationString :font];
    UITextView *translationLabel = [[UITextView alloc] initWithFrame:CGRectMake(10, 70+sourceContainerRect.size.height, 360, translationContainerRect.size.height+30)];
    
    sourceLabel.editable = true;
    [sourceLabel setText: sourceString ];
    [sourceLabel setTextColor:[UIColor blackColor]];
    [sourceLabel setBackgroundColor:[UIColor clearColor]];
    [sourceLabel setFont:font];
    sourceLabel.layer.borderWidth = 1.0f;
    sourceLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    sourceLabel.editable = TRUE;
    self.textarea = sourceLabel;
    //[self horizontallyMiddleAlign:self.translationPopup :sourceLabel];
    
    NSLog(@" translation : %@ ",translationString);
    
    translationLabel.editable = false;
    [translationLabel setText: translationString ];
    [translationLabel setTextColor:[UIColor blackColor]];
    [translationLabel setBackgroundColor:[UIColor clearColor]];
    [translationLabel setFont:font];
    //[self horizontallyMiddleAlign:self.translationPopup :translationLabel];
    
    UIButton *translateButton = [[UIButton alloc] initWithFrame: CGRectMake(10, sourceContainerRect.size.height+30, 80, 30)];
    [translateButton setTitle:@"Translate" forState:UIControlStateNormal];
    [translateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    translateButton.titleLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size:14.0f];
    [translateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    translateButton.layer.backgroundColor = [[UIColor colorWithRed:0.0f green:122.0f/255.0f blue:1.0f alpha:1.0f ] CGColor];
    [self horizontallyMiddleAlign:self.translationPanel :translateButton];
    [translateButton addTarget:self action:@selector(translateFromText:)forControlEvents:UIControlEventTouchUpInside];
    
    [self.translationPanel addSubview:sourceLabel];
    [self.translationPanel addSubview:translationLabel];
    [self.translationPanel addSubview:translateButton];
    [[self.translationPanel layer] setBorderColor:[[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] CGColor]];
    [[self.translationPanel layer] setBorderWidth:1];
    self.translationPanel.hidden = NO;
}

- (void)clearTranslation{
    if( [[self.translationPanel subviews] count] > 0  )
        for(id view in [self.translationPanel subviews] ){
            [view removeFromSuperview];
        }
}

+(TranslationController* )instance
{
    return instance;
}

-(CGRect)calculateContainerBounds:(NSString *)string:(UIFont *) font{
    CGSize maximumLabelSize = CGSizeMake(300, CGFLOAT_MAX);
    CGRect textRect = [string boundingRectWithSize:maximumLabelSize
                                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        attributes:@{NSFontAttributeName:font}
                                           context:nil];
    
    return textRect;
}

-(void)horizontallyMiddleAlign:(UIView *)container:(UIView *)subview{
    CGRect r = [subview frame];
    r.origin.x = container.bounds.size.width/2 - subview.bounds.size.width/2;
    [subview setFrame:r];
}

-(void)hide
{
    self.translationPanel.hidden = YES;
}

-(void)translateFromText:(UIButton *)sender
{
    NSLog(@" Translate text : %@ ", self.textarea.text );
    
    [self showTranslation:self.textarea.text];
}

@end
