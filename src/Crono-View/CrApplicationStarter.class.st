"
I'm a visitor to provide platform specific startup for the CrApplication. 
Different platform require different pieces to be put in place to provide a smooth integration, I make sure those pieces are done (see visit* methods for details).
"
Class {
	#name : #CrApplicationStarter,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'application',
		'mainWindow'
	],
	#category : #'Crono-View-Application'
}

{ #category : #accessing }
CrApplicationStarter >> application [

	^ application
]

{ #category : #accessing }
CrApplicationStarter >> application: anApplication [

	application := anApplication
]

{ #category : #accessing }
CrApplicationStarter >> mainWindow [

	^ mainWindow
]

{ #category : #'as yet unclassified' }
CrApplicationStarter >> start [

	mainWindow := CrTodoMainWindow new. 
	self visit.
	mainWindow openWithSpec
]

{ #category : #visiting }
CrApplicationStarter >> visitGeneric: platform [ 

"	mainWindow menu: self buildSystemMenu"
]

{ #category : #visiting }
CrApplicationStarter >> visitMacOS: platform [ 

"	mainWindow menu: self buildSystemMenu"
]
