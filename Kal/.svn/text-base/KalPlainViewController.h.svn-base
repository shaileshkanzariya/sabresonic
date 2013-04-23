/* 
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>
#import "KalView.h"       // for the KalViewDelegate protocol
#import "KalDataSource.h" // for the KalDataSourceCallbacks protocol

@class KalLogic, KalDate;

/*
 *    KalPlainViewController
 *    ------------------------
 *
 *  KalPlainViewController automatically creates both the calendar view
 *  and the events table view for you. The only thing you need to provide
 *  is a KalDataSource so that the calendar system knows which days to
 *  mark with a dot and which events to list under the calendar when a certain
 *  date is selected (just like in Apple's calendar app).
 *
 */
@interface KalPlainViewController : UIViewController <KalViewDelegate, KalDataSourceCallbacks>
{
	KalLogic *logic;
	id <KalViewDelegate> delegate;
	id <KalDataSource> dataSource;
	NSDate *initialSelectedDate;
	CGSize size;
}

@property (nonatomic, assign) id<KalViewDelegate> delegate;
@property (nonatomic, assign) id<KalDataSource> dataSource;
@property (nonatomic, retain) NSDate * initialSelectedDate;

- (id)initWithSelectedDate:(NSDate *)selectedDate; // designated initializer. When the calendar is first displayed to the user, the month that contains 'selectedDate' will be shown and the corresponding tile for 'selectedDate' will be automatically selected.
- (id)initWithSelectedDate:(NSDate *)selectedDate withSize:(CGSize)size;
// - (id)initWithSize:(CGSize)size;

- (void)reloadData; // If you change the KalDataSource after the KalPlainViewController has already been displayed to the user, you must call this method in order for the view to reflect the new data.
- (void)showAndSelectDate:(NSDate *)date; // Updates the state of the calendar to display the specified date's month and selects the tile for that date.

@end
