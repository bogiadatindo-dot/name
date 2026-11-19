#import <UIKit/UIKit.h>

static UIView *bottomBannerView = nil;
static UILabel *titleLabel = nil;
static NSTimer *rainbowTimer = nil;
static CGFloat colorHue = 0.0;

static void updateRainbowColor() {
    if (!titleLabel) return;
    // Thay đổi sắc độ màu (Hue) liên tục từ 0.0 đến 1.0
    colorHue += 0.01;
    if (colorHue > 1.0) colorHue = 0.0;
    
    titleLabel.textColor = [UIColor colorWithHue:colorHue saturation:1.0 brightness:1.0 alpha:1.0];
}

static void setupBottomBanner() {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = nil;
        for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                for (UIWindow *w in scene.windows) {
                    if (w.isKeyWindow) {
                        keyWindow = w;
                        break;
                    }
                }
            }
        }
        if (!keyWindow) return;

        if (bottomBannerView) {
            [bottomBannerView removeFromSuperview];
            [rainbowTimer invalidate];
            rainbowTimer = nil;
        }

        CGFloat screenWidth = keyWindow.bounds.size.width;
        CGFloat screenHeight = keyWindow.bounds.size.height;
        CGFloat barWidth = 280.0;
        CGFloat barHeight = 32.0;

        // Khung nền thanh màu tối mờ để làm nổi bật chữ cầu vồng
        bottomBannerView = [[UIView alloc] initWithFrame:CGRectMake((screenWidth - barWidth) / 2.0, screenHeight - barHeight - 16.0, barWidth, barHeight)];
        bottomBannerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        bottomBannerView.layer.cornerRadius = 6.0;
        bottomBannerView.layer.borderWidth = 1.0;
        bottomBannerView.layer.borderColor = [UIColor whiteColor].CGColor;
        bottomBannerView.userInteractionEnabled = NO; // Cho phép bấm xuyên qua
        bottomBannerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;

        titleLabel = [[UILabel alloc] initWithFrame:bottomBannerView.bounds];
        titleLabel.text = @"BOGIADAT X TEDTEAM";
        titleLabel.font = [UIColor.boldSystemFontOfSize] ? [UIFont boldSystemFontOfSize:14.0] : [UIFont systemFontOfSize:14.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        titleLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
        titleLabel.layer.shadowOpacity = 0.9;
        titleLabel.layer.shadowRadius = 2.0;

        [bottomBannerView addSubview:titleLabel];
        [keyWindow addSubview:bottomBannerView];

        // Khởi động bộ hẹn giờ đổi màu chữ liên tục (mỗi 0.05 giây)
        rainbowTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:[NSBlockOperation blockOperationWithBlock:^{
            updateRainbowColor();
        }] selector:@selector(main) userInfo:nil repeats:YES];
    });
}

%hook UIWindow
- (void)makeKeyAndVisible {
    %orig;
    setupBottomBanner();
}
%end
