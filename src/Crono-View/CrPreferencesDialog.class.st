Class {
	#name : #CrPreferencesDialog,
	#superclass : #CrPresenter,
	#instVars : [
		'optionsList',
		'panel',
		'allSettings'
	],
	#category : #'Crono-View-Todo-Preferences'
}

{ #category : #specs }
CrPreferencesDialog class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		beNotHomogeneous;
		add: #optionsList;
		add: #panel;
		yourself
]

{ #category : #accessing }
CrPreferencesDialog >> allSettings [

	^ allSettings ifNil: [ 
		allSettings := self createAllSettings ]
]

{ #category : #accessing }
CrPreferencesDialog >> createAllSettings [

	^ CrSettingPanel allSettings
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
