Class {
	#name : #CrSettingTheme,
	#superclass : #CrSettingPanel,
	#instVars : [
		'light',
		'dark'
	],
	#category : #'Crono-View-Todo-Preferences'
}

{ #category : #initialization }
CrSettingTheme >> initializePresenters [

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
CrSettingTheme >> title [

	^ 'Theme'
]
