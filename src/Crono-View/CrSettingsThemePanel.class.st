Class {
	#name : #CrSettingsThemePanel,
	#superclass : #CrSettingsPanel,
	#instVars : [
		'light',
		'dark'
	],
	#category : #'Crono-View-Todo-Settings'
}

{ #category : #accessing }
CrSettingsThemePanel class >> order [

	^ 10
]

{ #category : #initialization }
CrSettingsThemePanel >> initializePresenters [

	layout := SpBoxLayout newVertical
		borderWidth: 5;
		beNotHomogeneous;
		add: (light := self newRadioButton) expand: false;
		add: (dark := self newRadioButton) expand: false;
		yourself.
	
	light 
		label: 'Light Theme';
		whenActivatedDo: [ self useLightTheme ].
	dark 
		label: 'Dark Theme';
		whenActivatedDo: [ self useDarkTheme ].

	light associatedRadioButtons: { dark }
]

{ #category : #accessing }
CrSettingsThemePanel >> title [

	^ 'Theme'
]

{ #category : #initialization }
CrSettingsThemePanel >> updatePresenter [
	| isDark |
	
	isDark := self settings isDarkTheme.
	light state: isDark not.
	dark state: isDark
]

{ #category : #actions }
CrSettingsThemePanel >> useDarkTheme [
	
	self application useGtkDark.
	self settings 
		darkTheme: true;
		writeToFile
]

{ #category : #actions }
CrSettingsThemePanel >> useLightTheme [

	self application useGtk.
	self settings
		darkTheme: false;
		writeToFile
]
