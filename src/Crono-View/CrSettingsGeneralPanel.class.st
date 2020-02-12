Class {
	#name : #CrSettingsGeneralPanel,
	#superclass : #CrSettingsPanel,
	#instVars : [
		'light',
		'dark',
		'autoArchiveNumber'
	],
	#category : #'Crono-View-Todo-Preferences'
}

{ #category : #specs }
CrSettingsGeneralPanel class >> defaultSpec [

	^ SpGridLayout new
		add: 'Auto-archive completed tasks after (days)' at: 1@1; add: #autoArchiveNumber at: 1@2;
		yourself
]

{ #category : #accessing }
CrSettingsGeneralPanel class >> order [

	^ 0
]

{ #category : #initialization }
CrSettingsGeneralPanel >> initializePresenters [

	autoArchiveNumber := self newNumberInput
]

{ #category : #accessing }
CrSettingsGeneralPanel >> title [

	^ 'General'
]
