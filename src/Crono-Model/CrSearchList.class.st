"
I am a virtual list that will answer current searched tasks.
"
Class {
	#name : #CrSearchList,
	#superclass : #CrVirtualList,
	#instVars : [
		'searchText',
		'tasks'
	],
	#category : #'Crono-Model'
}

{ #category : #testing }
CrSearchList >> hasElements [

	^ self tasks isEmptyOrNil not
]

{ #category : #initialization }
CrSearchList >> initialize [

	super initialize.
	tasks := #()
]

{ #category : #private }
CrSearchList >> refresh [

	tasks := self searchText
		ifNotEmpty: [ :text | CrTodoTask findTasksMatching: '.*', text, '.*' ]
		ifEmpty: [ #() ]
]

{ #category : #accessing }
CrSearchList >> searchText [
	^ searchText
]

{ #category : #accessing }
CrSearchList >> searchText: aString [

	searchText = aString ifTrue: [ ^ self ].
	searchText := aString.
	self refresh
]

{ #category : #accessing }
CrSearchList >> tasks [

	^ tasks
]

{ #category : #accessing }
CrSearchList >> type [

	^ CrTodoTypeSearch uniqueInstance
]
