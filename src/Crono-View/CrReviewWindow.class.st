"
I define a window to show a review of the crono (you can go back as many days as desired)
"
Class {
	#name : #CrReviewWindow,
	#superclass : #CrCronoPresenter,
	#instVars : [
		'logText',
		'daysInput',
		'refreshButton',
		'reportText',
		'toolBar',
		'configuration'
	],
	#category : #'Crono-View-Crono'
}

{ #category : #specs }
CrReviewWindow class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
				spacing: 5;
				add: (SpBoxLayout newVertical 
					add: #daysInput expand: false fill: false padding: 5;
					yourself)
					expand: false;
				add: (SpBoxLayout newVertical 
					add: #refreshButton expand: false fill: false padding: 5;
					yourself)
					expand: false;
				addLast: #toolBar expand: false;
				yourself)
			expand: false;
		add: #reportText;
		yourself
]

{ #category : #private }
CrReviewWindow >> configuration [

	^ configuration ifNil: [ 
		configuration := CrReviewWindowConfiguration readFromFileSystem ]
]

{ #category : #private }
CrReviewWindow >> configurationClass [

	^ CrReviewWindowConfiguration
]

{ #category : #actions }
CrReviewWindow >> copyToClipboard [

	GtkClipboard forSelection text: reportText text asString
]

{ #category : #private }
CrReviewWindow >> initialBounds [
		
	^ self configuration bounds
]

{ #category : #private }
CrReviewWindow >> initialDays [
		
	^ self configuration reviewDays
]

{ #category : #initialization }
CrReviewWindow >> initializePresenters [

	daysInput := self newNumberInput 
		number: self initialDays.
	refreshButton := self newButton 
		label: 'Review';
		action: [ self review ];
		yourself.
	toolBar := self newToolBar
		beIcons;
		addItem: (SpToolBarButton new
			label: 'Copy';
			icon: (self iconNamed: #smallCopy);
			help: 'Copy to clipboard';
			action: [ self copyToClipboard ];
			yourself);
		yourself.
			
	reportText := self newText 
		addStyle: 'cronoText';
		enabled: false;
		yourself
]

{ #category : #initialization }
CrReviewWindow >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenBuiltDo: [ self review ]
]

{ #category : #'private factory' }
CrReviewWindow >> newRangeTo: aNumber [

	^ CrCronoRange 
		newFrom: (Date today - (aNumber - 1) days) asDate 
		to: Date today
]

{ #category : #actions }
CrReviewWindow >> review [
	| days |

	days := daysInput number.
	reportText text: (String streamContents: [ :stream |
		self newCrono 
			review: (self newRangeTo: days)
			to: (ZnNewLineWriterStream on: stream) ]).
	self updateTitle		
]

{ #category : #actions }
CrReviewWindow >> review: aNumber [

	self withWindowDo: [ :w | w title: ('Review {1} days' format: { aNumber }) ].
	reportText text: (String streamContents: [ :stream |
		self newCrono 
			review: (self newRangeTo: aNumber)
			to: (ZnNewLineWriterStream on: stream) ])
]

{ #category : #private }
CrReviewWindow >> storeSettingsInto: aConfiguration [

	aConfiguration reviewDays: daysInput number
]

{ #category : #private }
CrReviewWindow >> updateTitle [
	| days |

	days := daysInput number.
	self withWindowDo: [ :w | 
		w title: ('Review last {1} day{2}' format: { 
			days. 
			days > 1 ifTrue: [ 's' ] ifFalse: [ '']}) ]
]

{ #category : #events }
CrReviewWindow >> windowWillClose [

	self storeSettings
]
