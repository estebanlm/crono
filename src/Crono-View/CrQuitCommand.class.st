"
I'm the ""quit"" command. 
I exit the application.
"
Class {
	#name : #CrQuitCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Commands'
}

{ #category : #default }
CrQuitCommand class >> defaultName [

	^ 'Quit'
]

{ #category : #default }
CrQuitCommand class >> defaultShortcut [

	^ $q platformMeta
]
