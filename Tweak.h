#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>

@interface CKEntryViewButton: UIButton
@end

@interface CKMessageEntryRichTextView: UITextView
-(id)initWithFrame:(CGRect)arg1 textContainer:(id)arg2;
@end

@interface CKMessageEntryContentView: UIScrollView
-(CKMessageEntryRichTextView *)textView;
-(BOOL)textView:(id)arg1 shouldChangeTextInRange:(NSRange)arg2 replacementText:(id)arg3;
-(double)sendButtonTextInsetWidth;
@end


@interface CKMessageEntryView: UIView 

@property (nonatomic,retain) CKEntryViewButton * sendButton; 

-(CKMessageEntryContentView *)contentView;
-(CGSize)sendButtonSize; 
-(BOOL)shouldShowSendButton;
-(void)updateEntryView;
-(id)initWithFrame:(CGRect)arg1 marginInsets:(UIEdgeInsets)arg2 shouldAllowImpact:(BOOL)arg3 shouldShowSendButton:(BOOL)arg4 shouldShowSubject:(BOOL)arg5 shouldShowPluginButtons:(BOOL)arg6 shouldShowCharacterCount:(BOOL)arg7 traitCollection:(id)arg8;
-(id)initWithFrame:(CGRect)arg1 marginInsets:(UIEdgeInsets)arg2 shouldAllowImpact:(BOOL)arg3 shouldShowSendButton:(BOOL)arg4 shouldShowSubject:(BOOL)arg5 shouldShowPluginButtons:(BOOL)arg6 shouldShowCharacterCount:(BOOL)arg7 ;
-(void)touchUpInsideSendButton:(id)arg1;
-(void)sendMessageReceiver;
@end
