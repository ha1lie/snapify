#include "SNPRootListController.h"
#include "../NSTask.h"

@implementation SNPRootListController

static HBPreferences *preferences;

- (instancetype)init {
    self = [super init];

    if (self) {
        HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
        appearanceSettings.tintColor = [UIColor colorWithRed:(10.0/255.0) green:(132.0/255.0) blue:(255.0/255.0) alpha:1.0];
		appearanceSettings.tableViewCellSeparatorColor = [UIColor clearColor];
        // appearanceSettings.tableViewBackgroundColor = [UIColor colorWithWhite:242.f / 255.f alpha:1];
        self.hb_appearanceSettings = appearanceSettings;

		preferences = [[HBPreferences alloc] initWithIdentifier:@"com.halliehax.snapify.prefs"];
    }

    return self;
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Kill Messages" style:UIBarButtonItemStyleDone target:self action:@selector(respring)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:(10.0/255.0) green:(132.0/255.0) blue:(255.0/255.0) alpha:1.0];

	if (!self.navigationItem.titleView) {
		SNPAnimatedTitleView *titleView = [[SNPAnimatedTitleView alloc] initWithTitle:@"Snapify" minimumScrollOffsetRequired:-150];
		self.navigationItem.titleView = titleView;
	}
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
	//Send scroll offset updates to view
	if([self.navigationItem.titleView respondsToSelector:@selector(adjustLabelPositionToScrollOffset:)]) {
		[(SNPAnimatedTitleView *)self.navigationItem.titleView adjustLabelPositionToScrollOffset:scrollView.contentOffset.y];
	}
}

-(void)respring {
	//KILL MESSAGES APP ~ No need to respring!
	NSTask *killallSpringBoard = [[NSTask alloc] init];
    [killallSpringBoard setLaunchPath:@"/usr/bin/killall"];
    [killallSpringBoard setArguments:@[@"-9", @"MobileSMS"]];
    [killallSpringBoard launch];
}

@end
