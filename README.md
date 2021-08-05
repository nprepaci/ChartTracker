# ChartTracker

Simple application that leverages the TradingPhysics API to display stock data for a given day.

A user must enter a date that is at least one day prior to the current date. The date may not fall on a weekend or bank holiday. A user must also enter a valid stock ticket (e.g. 'QQQ'). Once all required fields are entered, a user must click the "Get Chart" button. The appropritate stock chart will appear. A user can then interact with the stock chart via pinch & zoom feature. 

If needed, the login screen can be circumvented by changing the launch view controller. If using the login screen is desired, you will need to follow the google firebase setup and link to your own firebase backend.
