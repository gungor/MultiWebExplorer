//
//  GoogleTranslator.h
//  MultiWebExplorer
//
//  Created by gungor on 3/17/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import <ObjectiveGumbo.h>

@interface GoogleTranslator : NSObject

+ (NSString *)translate: (NSString *)string;

@end

