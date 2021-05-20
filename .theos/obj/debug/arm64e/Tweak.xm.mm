#line 1 "Tweak.xm"
#import "Tweak.h"
#import "RemoteLog.h"


















HBPreferences *preferences;




#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SpringBoard; @class CKMessageEntryView; @class CKMessageEntryRichTextView; @class CKMessageEntryContentView; 


#line 25 "Tweak.xm"
static CKMessageEntryView* (*_logos_orig$TweakEnabled$CKMessageEntryView$initWithFrame$marginInsets$shouldAllowImpact$shouldShowSendButton$shouldShowSubject$shouldShowPluginButtons$shouldShowCharacterCount$traitCollection$)(_LOGOS_SELF_TYPE_INIT CKMessageEntryView*, SEL, CGRect, UIEdgeInsets, BOOL, BOOL, BOOL, BOOL, BOOL, id) _LOGOS_RETURN_RETAINED; static CKMessageEntryView* _logos_method$TweakEnabled$CKMessageEntryView$initWithFrame$marginInsets$shouldAllowImpact$shouldShowSendButton$shouldShowSubject$shouldShowPluginButtons$shouldShowCharacterCount$traitCollection$(_LOGOS_SELF_TYPE_INIT CKMessageEntryView*, SEL, CGRect, UIEdgeInsets, BOOL, BOOL, BOOL, BOOL, BOOL, id) _LOGOS_RETURN_RETAINED; static BOOL (*_logos_orig$TweakEnabled$CKMessageEntryView$shouldShowSendButton)(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryView* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$TweakEnabled$CKMessageEntryView$shouldShowSendButton(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryView* _LOGOS_SELF_CONST, SEL); static CGSize (*_logos_orig$TweakEnabled$CKMessageEntryView$sendButtonSize)(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryView* _LOGOS_SELF_CONST, SEL); static CGSize _logos_method$TweakEnabled$CKMessageEntryView$sendButtonSize(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryView* _LOGOS_SELF_CONST, SEL); static void _logos_method$TweakEnabled$CKMessageEntryView$sendMessageReceiver(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryView* _LOGOS_SELF_CONST, SEL); static BOOL (*_logos_orig$TweakEnabled$CKMessageEntryContentView$textView$shouldChangeTextInRange$replacementText$)(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryContentView* _LOGOS_SELF_CONST, SEL, UITextView *, NSRange, id); static BOOL _logos_method$TweakEnabled$CKMessageEntryContentView$textView$shouldChangeTextInRange$replacementText$(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryContentView* _LOGOS_SELF_CONST, SEL, UITextView *, NSRange, id); static double (*_logos_orig$TweakEnabled$CKMessageEntryContentView$sendButtonTextInsetWidth)(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryContentView* _LOGOS_SELF_CONST, SEL); static double _logos_method$TweakEnabled$CKMessageEntryContentView$sendButtonTextInsetWidth(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryContentView* _LOGOS_SELF_CONST, SEL); static CKMessageEntryRichTextView* (*_logos_orig$TweakEnabled$CKMessageEntryRichTextView$initWithFrame$textContainer$)(_LOGOS_SELF_TYPE_INIT CKMessageEntryRichTextView*, SEL, CGRect, id) _LOGOS_RETURN_RETAINED; static CKMessageEntryRichTextView* _logos_method$TweakEnabled$CKMessageEntryRichTextView$initWithFrame$textContainer$(_LOGOS_SELF_TYPE_INIT CKMessageEntryRichTextView*, SEL, CGRect, id) _LOGOS_RETURN_RETAINED; 



BOOL updatedOnce = NO;

static CKMessageEntryView* _logos_method$TweakEnabled$CKMessageEntryView$initWithFrame$marginInsets$shouldAllowImpact$shouldShowSendButton$shouldShowSubject$shouldShowPluginButtons$shouldShowCharacterCount$traitCollection$(_LOGOS_SELF_TYPE_INIT CKMessageEntryView* __unused self, SEL __unused _cmd, CGRect arg1, UIEdgeInsets arg2, BOOL arg3, BOOL arg4, BOOL arg5, BOOL arg6, BOOL arg7, id arg8) _LOGOS_RETURN_RETAINED {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessageReceiver) name:@"SNAPIFYSENDMESSAGE" object:nil];
	return _logos_orig$TweakEnabled$CKMessageEntryView$initWithFrame$marginInsets$shouldAllowImpact$shouldShowSendButton$shouldShowSubject$shouldShowPluginButtons$shouldShowCharacterCount$traitCollection$(self, _cmd, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
}

static BOOL _logos_method$TweakEnabled$CKMessageEntryView$shouldShowSendButton(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	
	if (![preferences boolForKey:@"keepSendButton" default:NO]) {
		return NO;
	} else {
		return YES;
	}
}

static CGSize _logos_method$TweakEnabled$CKMessageEntryView$sendButtonSize(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	if (![preferences boolForKey:@"keepSendButton" default:NO]) {
		return CGSizeMake(0, 0);
	} else {
		return _logos_orig$TweakEnabled$CKMessageEntryView$sendButtonSize(self, _cmd);
	}
}

 
static void _logos_method$TweakEnabled$CKMessageEntryView$sendMessageReceiver(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	[self touchUpInsideSendButton:nil];
}





static BOOL _logos_method$TweakEnabled$CKMessageEntryContentView$textView$shouldChangeTextInRange$replacementText$(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryContentView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITextView * arg1, NSRange arg2, id arg3) {
	if ([arg3 isEqual:@"\n"]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"SNAPIFYSENDMESSAGE" object:self];
		return NO;
	} else {	
		return _logos_orig$TweakEnabled$CKMessageEntryContentView$textView$shouldChangeTextInRange$replacementText$(self, _cmd, arg1, arg2, arg3);
	}
}

static double _logos_method$TweakEnabled$CKMessageEntryContentView$sendButtonTextInsetWidth(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryContentView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	
	if (![preferences boolForKey:@"keepSendButton" default:NO]) {
		return 0.0;
	} else {
		return _logos_orig$TweakEnabled$CKMessageEntryContentView$sendButtonTextInsetWidth(self, _cmd);
	}
}





static CKMessageEntryRichTextView* _logos_method$TweakEnabled$CKMessageEntryRichTextView$initWithFrame$textContainer$(_LOGOS_SELF_TYPE_INIT CKMessageEntryRichTextView* __unused self, SEL __unused _cmd, CGRect arg1, id arg2) _LOGOS_RETURN_RETAINED {
	CKMessageEntryRichTextView *orig = _logos_orig$TweakEnabled$CKMessageEntryRichTextView$initWithFrame$textContainer$(self, _cmd, arg1, arg2);
	orig.returnKeyType = UIReturnKeySend;
	[orig reloadInputViews];
	return orig;
}









static void (*_logos_orig$Unsupported$SpringBoard$applicationDidFinishLaunching$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$Unsupported$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, BOOL); 

static void _logos_method$Unsupported$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1) {
	_logos_orig$Unsupported$SpringBoard$applicationDidFinishLaunching$(self, _cmd, arg1);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh..." message:@"It seems to be that you're using Snapify on an upsupported iOS version ~ it won't work!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}







static __attribute__((constructor)) void _logosLocalCtor_7bd7f74f(int __unused argc, char __unused **argv, char __unused **envp) {
	
	if (!preferences) { 
		preferences = [[HBPreferences alloc] initWithIdentifier:@"com.halliehax.snapify.prefs"];
	}
	if ([preferences boolForKey:@"isEnabled" default:YES]) {
		if (@available(iOS 13.0, *)) {
			{Class _logos_class$TweakEnabled$CKMessageEntryView = objc_getClass("CKMessageEntryView"); { MSHookMessageEx(_logos_class$TweakEnabled$CKMessageEntryView, @selector(initWithFrame:marginInsets:shouldAllowImpact:shouldShowSendButton:shouldShowSubject:shouldShowPluginButtons:shouldShowCharacterCount:traitCollection:), (IMP)&_logos_method$TweakEnabled$CKMessageEntryView$initWithFrame$marginInsets$shouldAllowImpact$shouldShowSendButton$shouldShowSubject$shouldShowPluginButtons$shouldShowCharacterCount$traitCollection$, (IMP*)&_logos_orig$TweakEnabled$CKMessageEntryView$initWithFrame$marginInsets$shouldAllowImpact$shouldShowSendButton$shouldShowSubject$shouldShowPluginButtons$shouldShowCharacterCount$traitCollection$);}{ MSHookMessageEx(_logos_class$TweakEnabled$CKMessageEntryView, @selector(shouldShowSendButton), (IMP)&_logos_method$TweakEnabled$CKMessageEntryView$shouldShowSendButton, (IMP*)&_logos_orig$TweakEnabled$CKMessageEntryView$shouldShowSendButton);}{ MSHookMessageEx(_logos_class$TweakEnabled$CKMessageEntryView, @selector(sendButtonSize), (IMP)&_logos_method$TweakEnabled$CKMessageEntryView$sendButtonSize, (IMP*)&_logos_orig$TweakEnabled$CKMessageEntryView$sendButtonSize);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$TweakEnabled$CKMessageEntryView, @selector(sendMessageReceiver), (IMP)&_logos_method$TweakEnabled$CKMessageEntryView$sendMessageReceiver, _typeEncoding); }Class _logos_class$TweakEnabled$CKMessageEntryContentView = objc_getClass("CKMessageEntryContentView"); { MSHookMessageEx(_logos_class$TweakEnabled$CKMessageEntryContentView, @selector(textView:shouldChangeTextInRange:replacementText:), (IMP)&_logos_method$TweakEnabled$CKMessageEntryContentView$textView$shouldChangeTextInRange$replacementText$, (IMP*)&_logos_orig$TweakEnabled$CKMessageEntryContentView$textView$shouldChangeTextInRange$replacementText$);}{ MSHookMessageEx(_logos_class$TweakEnabled$CKMessageEntryContentView, @selector(sendButtonTextInsetWidth), (IMP)&_logos_method$TweakEnabled$CKMessageEntryContentView$sendButtonTextInsetWidth, (IMP*)&_logos_orig$TweakEnabled$CKMessageEntryContentView$sendButtonTextInsetWidth);}Class _logos_class$TweakEnabled$CKMessageEntryRichTextView = objc_getClass("CKMessageEntryRichTextView"); { MSHookMessageEx(_logos_class$TweakEnabled$CKMessageEntryRichTextView, @selector(initWithFrame:textContainer:), (IMP)&_logos_method$TweakEnabled$CKMessageEntryRichTextView$initWithFrame$textContainer$, (IMP*)&_logos_orig$TweakEnabled$CKMessageEntryRichTextView$initWithFrame$textContainer$);}}
		} else {
			
			{Class _logos_class$Unsupported$SpringBoard = objc_getClass("SpringBoard"); { MSHookMessageEx(_logos_class$Unsupported$SpringBoard, @selector(applicationDidFinishLaunching:), (IMP)&_logos_method$Unsupported$SpringBoard$applicationDidFinishLaunching$, (IMP*)&_logos_orig$Unsupported$SpringBoard$applicationDidFinishLaunching$);}}
		}
	}
}
