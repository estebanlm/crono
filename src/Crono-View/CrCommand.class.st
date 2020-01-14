Class {
	#name : #CrCommand,
	#superclass : #CmCommand,
	#category : #'Crono-View-Base'
}

{ #category : #default }
CrCommand class >> defaultIconName [

	^ nil
]

{ #category : #default }
CrCommand class >> defaultShortcut [

	^ nil
]

{ #category : #accessing }
CrCommand >> application [

	^ CrApplication current
]

{ #category : #converting }
CrCommand >> asSpecCommand [ 
	| command |
	
	command := super asSpecCommand 
		iconProvider: self application;
		iconName: self class defaultIconName;
		yourself.
		
	self class defaultShortcut 
		ifNotNil: [ :keyCombination | command shortcutKey: keyCombination ].
		
	^ command
]

{ #category : #accessing }
CrCommand >> notificationCenter [

	^ self application notificationCenter
]
