
#import <UIKit/UIKit.h>

static UILabel *nameLabel;

static void CreateNameBar(void) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = nil;

        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if (![scene isKindOfClass:UIWindowScene.class]) continue;

            for (UIWindow *w in ((UIWindowScene *)scene).windows) {
                if (w.isKeyWindow) {
                    window = w;
                    break;
                }
            }
        }

        if (!window || nameLabel) return;

        UILabel *label = [[UILabel alloc] init];
        label.text = @"PLAYER NAME";
        label.textColor = UIColor.whiteColor;
        label.font = [UIFont boldSystemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65];
        label.layer.cornerRadius = 7;
        label.clipsToBounds = YES;

        [window addSubview:label];

        label.translatesAutoresizingMaskIntoConstraints = NO;

        [NSLayoutConstraint activateConstraints:@[
            [label.centerXAnchor constraintEqualToAnchor:window.centerXAnchor],
            [label.topAnchor constraintEqualToAnchor:window.safeAreaLayoutGuide.topAnchor constant:75],
            [label.widthAnchor constraintEqualToConstant:220],
            [label.heightAnchor constraintEqualToConstant:34]
        ]];

        nameLabel = label;
    });
}

%ctor {
    @autoreleasepool {
        [[NSNotificationCenter defaultCenter]
         addObserverForName:UIApplicationDidBecomeActiveNotification
         object:nil
         queue:NSOperationQueue.mainQueue
         usingBlock:^(NSNotification *note) {
            CreateNameBar();
         }];
    }
}
