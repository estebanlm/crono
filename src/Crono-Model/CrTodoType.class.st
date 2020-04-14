"
I'm a list type.
"
Class {
	#name : #CrTodoType,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Crono-Model-Todo'
}

{ #category : #accessing }
CrTodoType class >> allTypes [

	^ CrTodoType allSubclasses collect: #uniqueInstance
]

{ #category : #accessing }
CrTodoType class >> archive [

	^ CrTodoTypeArchive uniqueInstance
]

{ #category : #accessing }
CrTodoType class >> focus [

	^ CrTodoTypeFocus uniqueInstance
]

{ #category : #'instance creation' }
CrTodoType class >> fromSton: stonReader [
	| typeName |
	
	typeName := stonReader parseListSingleton.
	^ self allTypes detect: [ :each | each name = typeName ]
]

{ #category : #accessing }
CrTodoType class >> inbox [

	^ CrTodoTypeInbox uniqueInstance
]

{ #category : #accessing }
CrTodoType class >> life [

	^ CrTodoTypeLife uniqueInstance
]

{ #category : #accessing }
CrTodoType class >> search [

	^ CrTodoTypeSearch uniqueInstance
]

{ #category : #'instance creation' }
CrTodoType class >> uniqueInstance [

	self = CrTodoType ifTrue: [ self error: 'I''m an abstract class. Use one of my children.' ].
	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #accessing }
CrTodoType class >> unsorted [

	^ CrTodoTypeUnsorted uniqueInstance
]

{ #category : #accessing }
CrTodoType class >> user [

	^ CrTodoTypeUser uniqueInstance
]

{ #category : #accessing }
CrTodoType >> defaultIconName [
	"This is the default icon to assing to a list when it is created"

	^ nil
]

{ #category : #accessing }
CrTodoType >> defaultName [
	"This is the default name to assing to a list when it is created"

	^ self name
]

{ #category : #testing }
CrTodoType >> isEditable [

	^ false
]

{ #category : #testing }
CrTodoType >> isVisible [

	^ true
]

{ #category : #accessing }
CrTodoType >> name [
	
	^ self subclassResponsibility
]

{ #category : #testing }
CrTodoType >> showsCompletion [

	^ true
]

{ #category : #testing }
CrTodoType >> showsFocus [

	^ true
]

{ #category : #testing }
CrTodoType >> showsPendingSize [

	^ false
]

{ #category : #accessing }
CrTodoType >> typeName [

	^ self subclassResponsibility
]
