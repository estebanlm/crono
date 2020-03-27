Class {
	#name : #CrSettingsGeneralPanel,
	#superclass : #CrSettingsPanel,
	#instVars : [
		'light',
		'dark',
		'autoArchiveNumber'
	],
	#category : #'Crono-View-Todo-Settings'
}

{ #category : #specs }
CrSettingsGeneralPanel class >> defaultSpec [

	^ SpGridLayout new
		beRowNotHomogeneous;
		beColumnNotHomogeneous;
		add: 'Auto-archive completed tasks after (days)' at: 1@1; 
		add: #autoArchiveNumber at: 1@2;
		yourself
]

{ #category : #accessing }
CrSettingsGeneralPanel class >> order [

	^ 0
]

{ #category : #initialization }
CrSettingsGeneralPanel >> initializePresenters [

	autoArchiveNumber := self newNumberInput
		number: self settings autoArchiveAfterDays;
		rangeMinimum: 1 maximum: 365;
		whenTextChangedDo: [ :text | 
			self moveAutoArchiveTo: (text trimmed 
				ifNotEmpty: [ text asNumber ]
				ifEmpty: [ 1 ]) ];
		yourself
]

{ #category : #actions }
CrSettingsGeneralPanel >> moveAutoArchiveTo: aNumber [

	self settings 
		autoArchiveAfterDays: aNumber;
		writeToFile
]

{ #category : #accessing }
CrSettingsGeneralPanel >> title [

	^ 'General'
]
