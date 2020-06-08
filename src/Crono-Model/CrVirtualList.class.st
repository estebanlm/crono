"
I am a virtual list. 
I can keep different kind of lists (for example, the focused tasks or archived, but also ""smart lists"").
The correspondent behaviour will be defined in my children.
"
Class {
	#name : #CrVirtualList,
	#superclass : #CrAbstractList,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Crono-Model-Todo'
}

{ #category : #accessing }
CrVirtualList class >> allLists [

	^ self allSubclasses collect: #uniqueInstance
]

{ #category : #'instance creation' }
CrVirtualList class >> new [

	self error: 'Use #uniqueInstance'
]

{ #category : #'instance creation' }
CrVirtualList class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #visiting }
CrVirtualList >> accept: aVisitor [

	^ aVisitor visitVirtualList: self
]

{ #category : #testing }
CrVirtualList >> isVirtual [

	^ true
]

{ #category : #accessing }
CrVirtualList >> listForAddTask [
	"We cannot use a virtual list as tasks repository (since they are calculated). 
	 In that case we need to provide one 'default', which will be 'unsorted'"

	^ CrTodoList inbox
]

{ #category : #accessing }
CrVirtualList >> name [

	^ self type name
]

{ #category : #initialization }
CrVirtualList >> onApplicationStart: anApplication [
	"Override this if the virtual list needs some initialization on startup"
]

{ #category : #actions }
CrVirtualList >> removeTask: aTask follow: follow [ 
	
	aTask owner
		removeTask: aTask 
		follow: follow.
]

{ #category : #actions }
CrVirtualList >> saveTask: aTask [ 
	"Adding a task here is in fact adding it to unsorted"
	
	^ self listForAddTask saveTask: aTask. 
]
