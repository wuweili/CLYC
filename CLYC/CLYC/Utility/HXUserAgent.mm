//
//  HXUserAgent.m
//  BJXH-patient
//
//  Created by wuweili on 14-10-29.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import "HXUserAgent.h"

@implementation HXUserAgent

-(void)dealloc
{
    
}

-(id)initWithObtainUserAgentBlock:(ObtainUserAgentBlock)block
{
    if (self = [super init])
    {
        self.obtainUserAgentBlock = block;
        [self obtainUserAgent];
    }
    
    return self;
}




-(void)obtainUserAgent
{
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    
//    [_webView loadRequest:[NSURLRequest requestWithURL:
//                           [NSURL URLWithString:@"http://www.eoe.cn"]]];

//     [self userAgentString];
    
    self.userAgent = [_webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    if (_obtainUserAgentBlock)
    {
        self.obtainUserAgentBlock(self.userAgent);
    }
    
}

-(void)userAgentString
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        while (self.userAgent == nil)
        {
            NSLog(@"%@", @"in while");
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
    });
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (webView == _webView) {
        self.userAgent = [request valueForHTTPHeaderField:@"User-Agent"];
        
        if (_obtainUserAgentBlock)
        {
            self.obtainUserAgentBlock(self.userAgent);
        }
        
        return NO;
    }
    return YES;
}






@end
