"
I am a simple dialog to request some information (a text)
"
Class {
	#name : #CrRequestDialog,
	#superclass : #CrPresenter,
	#instVars : [
		'label',
		'textInput',
		'title',
		'initialExtent',
		'acceptLabel',
		'cancelLabel'
	],
	#category : #'Crono-View-Base'
}

{ #category : #accessing }
CrRequestDialog class >> defaultAcceptLabel [

	^ 'Accept'
]

{ #category : #accessing }
CrRequestDialog class >> defaultCancelLabel [

	^ 'Cancel'
]

{ #category : #accessing }
CrRequestDialog class >> defaultExtent [

	^ 400@100
]

{ #category : #specs }
CrRequestDialog class >> defaultSpec [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add: #label expand: false;
		add: #textInput expand: false;
		yourself
]

{ #category : #accessing }
CrRequestDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #accessing }
CrRequestDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #accessing }
CrRequestDialog >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : #accessing }
CrRequestDialog >> cancelLabel: aString [

	cancelLabel := aString
]

{ #category : #accessing }
CrRequestDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #accessing }
CrRequestDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : #initialization }
CrRequestDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addButton: self cancelLabel do: [ :presenter | presenter beCancel; close ];
		addDefaultButton: self acceptLabel do: [ :presenter | presenter beOk; close ]
		
]

{ #category : #initialization }
CrRequestDialog >> initializePresenters [

	label := self newLabel.
	textInput := self newTextInput
]

{ #category : #initialization }
CrRequestDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent;
		whenOpenedDo: [ textInput takeKeyboardFocus ]
]

{ #category : #accessing }
CrRequestDialog >> label: aString [

	label label: aString
]

{ #category : #accessing }
CrRequestDialog >> text [ 
	
	^ textInput text trimmed
]

{ #category : #accessing }
CrRequestDialog >> text: aString [

	textInput text: aString
]

{ #category : #accessing }
CrRequestDialog >> title [

	^ title
]

{ #category : #accessing }
CrRequestDialog >> title: aString [

	title := aString
]
