Class {
	#name : #CrSelectionablePanel,
	#superclass : #SpPresenter,
	#instVars : [
		'headerBar',
		'presenter',
		'shortcut'
	],
	#category : #'Crono-View-Base'
}

{ #category : #specs }
CrSelectionablePanel class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #headerBar expand: false fill: false padding: 5;
		add: #presenter;
		yourself
]

{ #category : #initialization }
CrSelectionablePanel >> addGlobalShortcutsTo: aWindowPresenter [
	
	shortcut ifNil: [ ^ self ].
	aWindowPresenter 
		bindKeyCombination: shortcut 
		toAction: [ self presenter firstResponder takeKeyboardFocus ]
]

{ #category : #initialization }
CrSelectionablePanel >> defineInputPorts [ 
	
	^ self presenter defineInputPorts
		collect: [ :each | 
			each copy 
				delegateTo: [ self presenter ];
				yourself ]
]

{ #category : #accessing }
CrSelectionablePanel >> firstResponder [

	^ self presenter
]

{ #category : #accessing }
CrSelectionablePanel >> headerBar [

	^ headerBar
]

{ #category : #accessing }
CrSelectionablePanel >> image: anImage [ 
	
	headerBar image: anImage
]

{ #category : #initialization }
CrSelectionablePanel >> initializePresenters [

	self instantiateHeaderBar: CrHeaderBar
]

{ #category : #'instance creation' }
CrSelectionablePanel >> instantiateHeaderBar: aPresenterClass [ 

	headerBar := self instantiate: aPresenterClass
]

{ #category : #'instance creation' }
CrSelectionablePanel >> instantiateHeaderBar: aPresenterClass on: aModel [

	headerBar := self 
		instantiate: aPresenterClass 
		on: aModel
]

{ #category : #'instance creation' }
CrSelectionablePanel >> instantiatePresenter: aPresenterClass [ 

	presenter := self instantiate: aPresenterClass
]

{ #category : #'instance creation' }
CrSelectionablePanel >> instantiatePresenter: aPresenterClass on: aModel [

	presenter := self 
		instantiate: aPresenterClass
		on: aModel
]

{ #category : #accessing }
CrSelectionablePanel >> panelNumber: aNumber [

	shortcut := self shortcutForPanel: aNumber.
	headerBar shortcut: shortcut
]

{ #category : #accessing }
CrSelectionablePanel >> presenter [

	^ presenter
]

{ #category : #private }
CrSelectionablePanel >> shortcutForPanel: aNumber [
	"This is a convenience method to assign shortcuts to panels. 
	 panels will be different areas of a tool: a package panel in a browser, an inspector in 
	 the debugger."
	| char |
	
	char := aNumber asString first.
	^ char command mac 
		| char control win 
		| char control unix
]

{ #category : #accessing }
CrSelectionablePanel >> title: aString [

	headerBar title: aString
]
