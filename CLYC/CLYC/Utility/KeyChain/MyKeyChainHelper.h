
#import <Foundation/Foundation.h>

@interface MyKeyChainHelper : NSObject

+ (void) saveUserName:(NSString*)userName 
      userNameService:(NSString*)userNameService 
             psaaword:(NSString*)pwd 
      psaawordService:(NSString*)pwdService;

+(void)clearUserPasswordWithpsaawordKeyChain:(NSString*)psaawordKeyChain;





+ (void) deleteWithUserNameService:(NSString*)userNameService 
                   psaawordService:(NSString*)pwdService;

+ (NSString*) getUserNameWithService:(NSString*)userNameService;

+ (NSString*) getPasswordWithService:(NSString*)pwdService;


+ (void)saveRegistrationId:(NSString *)ridStr;

+ (NSString *)getRegistrationId;

@end
