Class {
	#name : #CrOpenPlaygroundCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrOpenPlaygroundCommand class >> defaultDescription [

	^ 'Open a Pharo Playground.'
]

{ #category : #default }
CrOpenPlaygroundCommand class >> defaultIconName [

	^ 'system'
]

{ #category : #default }
CrOpenPlaygroundCommand class >> defaultName [

	^ 'Playground'
]

{ #category : #executing }
CrOpenPlaygroundCommand >> execute [
	
	context doOpenPlayground
]
