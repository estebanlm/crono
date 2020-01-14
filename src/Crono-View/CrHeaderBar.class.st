Class {
	#name : #CrHeaderBar,
	#superclass : #SpPresenter,
	#instVars : [
		'iconImage',
		'titleLabel',
		'shortcutLabel'
	],
	#category : #'Crono-View-Base'
}

{ #category : #specs }
CrHeaderBar class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		spacing: 5;
		add: #iconImage expand: false fill: false padding: 5;
		add: #titleLabel expand: false;
		add: #shortcutLabel expand: false;
		yourself
]

{ #category : #accessing }
CrHeaderBar >> image: anImage [ 

	iconImage image: anImage
]

{ #category : #initialization }
CrHeaderBar >> initializePresenters [

	iconImage := self newImage.
	titleLabel := self newLabel 
		addStyle: 'title'.
	shortcutLabel := self newLabel
		addStyle: 'titleShortcut'
]

{ #category : #accessing }
CrHeaderBar >> shortcut: aShortcut [

	shortcutLabel label: (KMShortcutPrinter toString: aShortcut)
]

{ #category : #accessing }
CrHeaderBar >> title: aString [

	titleLabel label: aString
]
