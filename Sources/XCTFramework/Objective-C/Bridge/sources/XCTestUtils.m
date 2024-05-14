#import "../include/XCTTestUtils.h"

void XTCStopTest(NSString *reason)
{
    XCTThrowException([NSException exceptionWithName:@"com.xct.mockable.TestFailure"
                                              reason:reason
                                            userInfo:nil]);
}

void XCTThrowException(NSException *exception)
{
    @throw exception;
}

NSException *_Nullable XCTTryExceptionBlock(void(^_Nonnull NS_NOESCAPE block)(void))
{
    @try {
        block();
    }
    @catch (NSException *exception) {
        return exception;
    }
    
    return nil;
}
