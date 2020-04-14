"
I am a base presenter for the Crono project. 
I define common behaviour for all Crono windows and panels, such as: 

- save/retrieve window configurations.
- configure the window with the common parameters.
- apply window keybindings
- apply window toolbar/menu actions
"
Class {
	#name : #CrPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#parentWindow => WeakSlot'
	],
	#category : #'Crono-View-Base'
}

{ #category : #accessing }
CrPresenter class >> currentApplication [ 

	^ CrApplication current
]

{ #category : #'instance creation' }
CrPresenter class >> new [

	^ self newApplication: CrApplication current
]

{ #category : #'instance creation' }
CrPresenter class >> open [
	<script>
	
	^ self new openWithSpec
]

{ #category : #'instance creation' }
CrPresenter class >> openDialog [
	<script>
	
	^ self new openDialogWithSpec
]

{ #category : #private }
CrPresenter >> configurationClass [
	
	^ nil
]

{ #category : #initialization }
CrPresenter >> initialize [
	super initialize.
]

{ #category : #initialization }
CrPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	self parentWindow 
		ifNotNil: [ :w | aDialogWindowPresenter centeredRelativeTo: w ] 
		ifNil: [ aDialogWindowPresenter centered ]
]

{ #category : #initialization }
CrPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter title: self title.
	self withConfigurationDo: [ :configuration |
		aWindowPresenter
			initialPosition: configuration bounds origin;
			initialExtent: configuration bounds extent;
			whenWillCloseDo: [ self storeSettings ] ].
	self traversePresentersDo: [ :each |
		each addGlobalShortcutsTo: aWindowPresenter ]
]

{ #category : #api }
CrPresenter >> openDialogWithSpecParent: aWindow [ 
	
	parentWindow := aWindow.
	^ self openDialogWithSpec
]

{ #category : #accessing }
CrPresenter >> parentWindow [

	^ parentWindow
]

{ #category : #private }
CrPresenter >> storeSettings [

	self withConfigurationDo: [ :configuration |
		self storeSettingsInto: configuration.
		configuration 
			bounds: self window window bounds;
			writeToFile ]
]

{ #category : #private }
CrPresenter >> storeSettingsInto: aConfiguration [
]

{ #category : #initialization }
CrPresenter >> title [

	^ 'NONAME'
]

{ #category : #private }
CrPresenter >> withConfigurationDo: aBlock [

	self configurationClass ifNil: [ ^ self ].
	aBlock value: self configurationClass readFromFileSystem
]
