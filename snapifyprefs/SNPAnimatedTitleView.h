#import <UIKit/UIKit.h>

//CREDITS FOR THIS CELL TO LACERTOSUS: 
//DISCORD: Bezerk#4824
//GITHUB: LacertosusRepo
//TWITTER: @LacertosusDeus

@interface SNPAnimatedTitleView : UIView
-(instancetype)initWithTitle:(NSString *)title minimumScrollOffsetRequired:(CGFloat)minimumOffset;
-(void)adjustLabelPositionToScrollOffset:(CGFloat)offset;
@end