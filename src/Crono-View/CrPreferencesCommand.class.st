Class {
	#name : #CrPreferencesCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Commands'
}

{ #category : #default }
CrPreferencesCommand class >> defaultName [

	^ 'Preferences...'
]

{ #category : #default }
CrPreferencesCommand class >> defaultShortcut [

	^ $, platformMeta
]
