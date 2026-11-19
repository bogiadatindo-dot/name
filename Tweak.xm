
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

static UIView *rainbowBar;

static void CreateRainbowBar(void) {
    UIWindow *window = nil;

    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (![scene isKindOfClass:UIWindowScene.class]) continue;

        for (UIWindow *w in ((UIWindowScene *)scene).windows) {
            if (w.isKeyWindow) {
                window = w;
                break;
            }
        }
        if (window) break;
    }

    if (!window || rainbowBar) return;

    UIView *bar = [[UIView alloc] init];
    bar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65];
    bar.layer.cornerRadius = 7;
    bar.layer.borderWidth = 1.5;
    bar.layer.borderColor = UIColor.cyanColor.CGColor;
    bar.clipsToBounds = YES;

    UILabel *label = [[UILabel alloc] init];
    label.text = @"Bogiadat X Ted Team";
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.whiteColor;
    label.frame = CGRectMake(0, 0, 220, 34);

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = label.bounds;
    gradient.colors = @[
        (id)[UIColor.redColor CGColor],
        (id)[UIColor.orangeColor CGColor],
        (id)[UIColor.yellowColor CGColor],
        (id)[UIColor.greenColor CGColor],
        (id)[UIColor.cyanColor CGColor],
        (id)[UIColor.blueColor CGColor],
        (id)[UIColor.magentaColor CGColor],
        (id)[UIColor.redColor CGColor]
    ];

    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);

    [gradient addAnimation:({
        CABasicAnimation *a =
        [CABasicAnimation animationWithKeyPath:@"locations"];
        a.fromValue = @[@0, @0.15, @0.3, @0.45,
                        @0.6, @0.75, @0.9, @1];
        a.toValue = @[@-1, @-0.85, @-0.7, @-0.55,
                      @-0.4, @-0.25, @-0.1, @0];
        a.duration = 3.0;
        a.repeatCount = HUGE_VALF;
        a;
    }) forKey:@"rainbow"];

    gradient.mask = ({
        CALayer *mask = [CALayer layer];
        mask.frame = label.bounds;
        mask.contents = (__bridge id)[self_placeholder CGImage];
        mask;
    });

    [bar addSubview:label];
    [window addSubview:bar];

    bar.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [bar.centerXAnchor constraintEqualToAnchor:window.centerXAnchor],
        [bar.topAnchor constraintEqualToAnchor:window.safeAreaLayoutGuide.topAnchor
                                       constant:75],
        [bar.widthAnchor constraintEqualToConstant:220],
        [bar.heightAnchor constraintEqualToConstant:34]
    ]];

    rainbowBar = bar;
}

%ctor {
    @autoreleasepool {
        [[NSNotificationCenter defaultCenter]
         addObserverForName:UIApplicationDidBecomeActiveNotification
         object:nil
         queue:NSOperationQueue.mainQueue
         usingBlock:^(NSNotification *note) {
            CreateRainbowBar();
         }];
    }
}
