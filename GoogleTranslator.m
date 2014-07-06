//
//  GoogleTranslator.m
//  MultiWebExplorer
//
//  Created by gungor on 3/17/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import "GoogleTranslator.h"

@implementation GoogleTranslator


+ (NSString *)translate: (NSString *)string
{
    OGNode * data = [ObjectiveGumbo parseDocumentWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"http://translate.google.com/translate_a/t?client=t&text=%@&hl=en&sl=auto&tl=en&ie=UTF-8&oe=UTF-8&multires=1&otf=1&pc=1&trs=1&ssel=3&tsel=6&sc=1", [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]];
    
    //Removes successive commas in the response string
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: @",(,)*"
                                                                           options: NSRegularExpressionCaseInsensitive
                                                                             error: nil];

    NSString *str = [regex stringByReplacingMatchesInString: [data text] options:0 range:NSMakeRange(0,[[data text] length]) withTemplate: @"," ];
    
    
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization  JSONObjectWithData:jsonData  options:kNilOptions error: &e ];
    NSMutableArray *firstItem = [[jsonArray objectAtIndex:0] objectAtIndex:0];
    
    return [firstItem objectAtIndex:0];
}


@end
