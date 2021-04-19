"
I open the preferences dialog.
"
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

	^ (KeyboardKey named: 'COMMA') asKeyCombination platformMeta
]

{ #category : #executing }
CrPreferencesCommand >> execute [
	
	(CrPreferencesDialog newApplication: self application) openDialogWithSpec
]
