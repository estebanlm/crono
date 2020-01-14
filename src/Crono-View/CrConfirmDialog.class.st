Class {
	#name : #CrConfirmDialog,
	#superclass : #CrPresenter,
	#instVars : [
		'label',
		'image',
		'title',
		'initialExtent',
		'acceptLabel',
		'cancelLabel'
	],
	#category : #'Crono-View-Base'
}

{ #category : #accessing }
CrConfirmDialog class >> defaultAcceptLabel [

	^ 'Yes'
]

{ #category : #accessing }
CrConfirmDialog class >> defaultCancelLabel [

	^ 'No'
]

{ #category : #accessing }
CrConfirmDialog class >> defaultExtent [

	^ 400@100
]

{ #category : #specs }
CrConfirmDialog class >> defaultSpec [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add: (SpBoxLayout newHorizontal
			spacing: 5;
			add: #image expand: false;
			add: #label;
			yourself);
		yourself
]

{ #category : #accessing }
CrConfirmDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #accessing }
CrConfirmDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #accessing }
CrConfirmDialog >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : #accessing }
CrConfirmDialog >> cancelLabel: aString [

	cancelLabel := aString
]

{ #category : #accessing }
CrConfirmDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #accessing }
CrConfirmDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : #initialization }
CrConfirmDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addButton: self cancelLabel do: [ :presenter | presenter beCancel; close ];
		addDefaultButton: self acceptLabel do: [ :presenter | presenter beOk; close ]
		
]

{ #category : #initialization }
CrConfirmDialog >> initializePresenters [

	image := self newImage.
	label := self newLabel.
	
]

{ #category : #initialization }
CrConfirmDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent
]

{ #category : #accessing }
CrConfirmDialog >> label: aString [

	label label: aString
]

{ #category : #accessing }
CrConfirmDialog >> title [

	^ title
]

{ #category : #accessing }
CrConfirmDialog >> title: aString [

	title := aString
]
