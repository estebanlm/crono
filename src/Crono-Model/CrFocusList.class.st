"
I am a virtual list that will answer focused tasks.
"
Class {
	#name : #CrFocusList,
	#superclass : #CrVirtualList,
	#instVars : [
		'tasksCache'
	],
	#category : #'Crono-Model'
}

{ #category : #accessing }
CrFocusList >> basicTasks [

	^ CrTodoTask selectMany: [ :each | each at: 'focused' ]	

]

{ #category : #accessing }
CrFocusList >> name [

	^ self type name
]

{ #category : #'notification handling' }
CrFocusList >> noteListChanged: aNotification [
	
	aNotification list type = CrTodoType focus ifFalse: [ ^ self ].
	self resetCache
]

{ #category : #'notification handling' }
CrFocusList >> noteVirtualListTaskChanged: aNotification [
	"do nothing (prevent unnecesary refresh)"
]

{ #category : #initialization }
CrFocusList >> onApplicationStart: anApplication [ 

	self resetCache.
	anApplication notificationCenter 
		subscribeHigh: self
		to: CrListChangedNotification
]

{ #category : #private }
CrFocusList >> resetCache [

	tasksCache := nil
]

{ #category : #actions }
CrFocusList >> saveTask: aTask [

	aTask focus: true.
	super saveTask: aTask
]

{ #category : #accessing }
CrFocusList >> tasks [

	^ tasksCache ifNil: [ tasksCache := self basicTasks ]
]

{ #category : #accessing }
CrFocusList >> type [

	^ CrTodoType focus
]