//
//  Utility.m
//  MultiWebExplorer
//
//  Created by gungor on 8/4/14.
//  Copyright (c) 2014 gungor. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSString *)checkUrl: (NSString *)url
{
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"] ) {
        return url;
    }else {
        return [NSString stringWithFormat:@"http://%@", url];
    }
}

@end
