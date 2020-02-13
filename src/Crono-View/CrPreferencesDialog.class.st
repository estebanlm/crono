Class {
	#name : #CrPreferencesDialog,
	#superclass : #CrPresenter,
	#instVars : [
		'optionsList',
		'panel',
		'allSettings'
	],
	#category : #'Crono-View-Todo-Settings'
}

{ #category : #specs }
CrPreferencesDialog class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		borderWidth: 5;
		beNotHomogeneous;
		add: #optionsList withConstraints: [ :c | c width: 200 ];
		addLast: #panel;
		yourself
]

{ #category : #accessing }
CrPreferencesDialog >> allSettings [

	^ allSettings ifNil: [ 
		allSettings := self createAllSettings ]
]

{ #category : #accessing }
CrPreferencesDialog >> createAllSettings [

	^ CrSettingsPanel allSettings
]

{ #category : #initialization }
CrPreferencesDialog >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter centeredRelativeToTopWindow
]

{ #category : #initialization }
CrPreferencesDialog >> initializePresenters [

	optionsList := self newList 
		items: self allSettings;
		display: [ :each | each title ];
		yourself.
	panel := self instantiate: CrPreferencesContainerPanel.
	optionsList transmitTo: panel
]

{ #category : #initialization }
CrPreferencesDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Preferences';
		initialExtent: 600@400
]
