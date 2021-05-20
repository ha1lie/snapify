#import "Tweak.h"
#import "RemoteLog.h"

//MARK: How does it work?

//Step 1 ~ Let's get rid of the send button ~ after we figure out what it calls :)
//       ~ Calls touchUpInsideSendButton on CKMessageEntryView
//Step 2 ~ Let's figure out how to get the textfield!
//       ~ Found CKMessageEntryRichTextView
//Step 3 ~ Change the return key to send key
//       ~ Simple enough, but make sure to reloadInputViews on the text view
//Step 4 ~ Run function on return
//       ~ Find textView delegate
//       ~ Change function onUpdate, and check for newline
//Step 5 ~ Send notification to send the message to super super view
//       ~ Add and send NSNotificationCenter notification when "return" key is pressed
//Step 6 ~ Fix the UI offset where the button used to be
//       ~ Change the sendButtonSize

//MARK: PREFERENCE OBJECT
HBPreferences *preferences;

//MARK: Enabled Tweak Hooks

%group TweakEnabled

%hook CKMessageEntryView

BOOL updatedOnce = NO;

-(id)initWithFrame:(CGRect)arg1 marginInsets:(UIEdgeInsets)arg2 shouldAllowImpact:(BOOL)arg3 shouldShowSendButton:(BOOL)arg4 shouldShowSubject:(BOOL)arg5 shouldShowPluginButtons:(BOOL)arg6 shouldShowCharacterCount:(BOOL)arg7 traitCollection:(id)arg8 {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessageReceiver) name:@"SNAPIFYSENDMESSAGE" object:nil];
	return %orig;
}

-(BOOL)shouldShowSendButton {
	// RLog(@"SHOULD SHOW RETURN BUTTON!");
	if (![preferences boolForKey:@"keepSendButton" default:NO]) {
		return NO;
	} else {
		return YES;
	}
}

-(CGSize)sendButtonSize {
	if (![preferences boolForKey:@"keepSendButton" default:NO]) {
		return CGSizeMake(0, 0);
	} else {
		return %orig;
	}
}

%new 
-(void)sendMessageReceiver {
	[self touchUpInsideSendButton:nil];
}

%end

%hook CKMessageEntryContentView

-(BOOL)textView:(UITextView *)arg1 shouldChangeTextInRange:(NSRange)arg2 replacementText:(id)arg3 {
	if ([arg3 isEqual:@"\n"]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"SNAPIFYSENDMESSAGE" object:self];
		return NO;
	} else {	
		return %orig;
	}
}

-(double)sendButtonTextInsetWidth {
	
	if (![preferences boolForKey:@"keepSendButton" default:NO]) {
		return 0.0;
	} else {
		return %orig;
	}
}

%end

%hook CKMessageEntryRichTextView

-(id)initWithFrame:(CGRect)arg1 textContainer:(id)arg2 {
	CKMessageEntryRichTextView *orig = %orig;
	orig.returnKeyType = UIReturnKeySend;
	[orig reloadInputViews];
	return orig;
}

%end

%end



//MARK: UNSUPPORTED IOS VERSION

%group Unsupported
%hook SpringBoard
-(void)applicationDidFinishLaunching:(BOOL)arg1 {
	%orig(arg1);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh..." message:@"It seems to be that you're using Snapify on an upsupported iOS version ~ it won't work!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}
%end
%end



//MARK: Constructor

%ctor {
	//Do a check to see if it's enabled
	if (!preferences) { //Initiate preferences instead of making it a compile-time constant
		preferences = [[HBPreferences alloc] initWithIdentifier:@"com.halliehax.snapify.prefs"];
	}
	if ([preferences boolForKey:@"isEnabled" default:YES]) {
		if (@available(iOS 13.0, *)) {
			%init(TweakEnabled);
		} else {
			//Not supported
			%init(Unsupported);
		}
	}
}