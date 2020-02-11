Class {
	#name : #CrPreferenceTheme,
	#superclass : #CrSettingPanel,
	#instVars : [
		'light',
		'dark'
	],
	#category : #'Crono-View-Todo-Preferences'
}

{ #category : #initialization }
CrPreferenceTheme class >> defaultLayout [

	^ SpBoxLayout newVertical
]

{ #category : #initialization }
CrPreferenceTheme >> initializePresenters [

	layout := SpBoxLayout newVertical
		add: (light := self newRadioButton);
		add: (dark := self newRadioButton);
		yourself.
		
	light label: 'Light Theme'.
	light associatedRadioButtons: { dark }.
	
	dark label: 'Dark Theme'
]

{ #category : #accessing }
CrPreferenceTheme >> title [

	^ 'Theme'
]
