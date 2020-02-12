Class {
	#name : #CrSettingsThemePanel,
	#superclass : #CrSettingsPanel,
	#instVars : [
		'light',
		'dark'
	],
	#category : #'Crono-View-Todo-Preferences'
}

{ #category : #accessing }
CrSettingsThemePanel class >> order [

	^ 10
]

{ #category : #initialization }
CrSettingsThemePanel >> initializePresenters [

	layout := SpBoxLayout newVertical
		beNotHomogeneous;
		add: (light := self newRadioButton) expand: false;
		add: (dark := self newRadioButton) expand: false;
		yourself.
		
	light label: 'Light Theme'.
	light associatedRadioButtons: { dark }.
	
	dark label: 'Dark Theme'
]

{ #category : #accessing }
CrSettingsThemePanel >> title [

	^ 'Theme'
]
