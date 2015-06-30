//
//  HTNetwork.h
//  IOS-IM
//
//  Created by xishuaishuai on 13-9-14.
//  Copyright (c) 2013年 weihua. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Reachability;

@interface HTNetwork : NSObject {
    Reachability *_wifi;
    Reachability *_carrier;
}


+ (HTNetwork *)sharedInstance;
+ (BOOL)isNetworkAvailable;

- (void)startListening;
- (void)stopListening;

- (void)reachabilityChanged;
@end

