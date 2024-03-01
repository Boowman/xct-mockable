#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void XCTStopTest(NSString *reason);

void XCTThrowException(NSException *reason);

NSException *_Nullable XCTTryExceptionBlock(void(^_Nonnull NS_NOESCAPE block)(void));

NS_ASSUME_NONNULL_END
