"
I define a dialog to add a new log entry to crono.
"
Class {
	#name : #CrCronoDialog,
	#superclass : #CrCronoPresenter,
	#instVars : [
		'logText'
	],
	#category : #'Crono-View-Crono'
}

{ #category : #specs }
CrCronoDialog class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #logText;
		yourself
]

{ #category : #actions }
CrCronoDialog >> addCrono [

	self newCrono log: logText text asString
]

{ #category : #initialization }
CrCronoDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter 
		addButton: 'Cancel' do: [ :presenter | presenter beCancel; close ];
		addDefaultButton: ('Crono' " format: { KMShortcutPrinter toString: Character cr alt }")
			do: [ :presenter |
				self addCrono.
				presenter beOk; close ]
]

{ #category : #initialization }
CrCronoDialog >> initializePresenters [

	logText := self newText
		placeholder: 'Enter your crono log entry';
		addStyle: 'cronoText';
			bindKeyCombination: Character cr alt toAction: [ 
			self addCrono.
			self window close ];
		yourself.
		
	logText takeKeyboardFocus
]

{ #category : #initialization }
CrCronoDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Crono';
		initialExtent: 500@150;
		whenOpenedDo: [ logText takeKeyboardFocus ]
]
