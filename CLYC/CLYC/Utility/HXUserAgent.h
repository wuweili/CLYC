//
//  HXUserAgent.h
//  BJXH-patient
//
//  Created by wuweili on 14-10-29.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ObtainUserAgentBlock)(NSString *userAgentStr);

@interface HXUserAgent : NSObject<UIWebViewDelegate>
{
    UIWebView *_webView;
    
}

@property(nonatomic,strong)NSString *userAgent;

@property (nonatomic, copy) ObtainUserAgentBlock obtainUserAgentBlock;

-(id)initWithObtainUserAgentBlock:(ObtainUserAgentBlock)block;

@end
