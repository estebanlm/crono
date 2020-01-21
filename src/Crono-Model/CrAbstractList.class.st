"
I am a base for lists.
My childrne define whether this is a real list or a virtual, but in any case I have always a type, a name and a lists of tasks.
"
Class {
	#name : #CrAbstractList,
	#superclass : #Object,
	#category : #'Crono-Model'
}

{ #category : #actions }
CrAbstractList >> archiveCompletedTasks [

	self tasks do: [ :each | each archiveIfDone ]
]

{ #category : #actions }
CrAbstractList >> archiveCompletedTasksAfterDays: daysNumber [

	self tasks do: [ :each | each archiveIfDoneAfterDays: daysNumber ]
]

{ #category : #accessing }
CrAbstractList >> doneTasks [

	^ self tasks select: #isDone
]

{ #category : #accessing }
CrAbstractList >> doneTasksSize [

	^ self doneTasks size
]

{ #category : #accessing }
CrAbstractList >> iconName [

	^ self type defaultIconName
]

{ #category : #testing }
CrAbstractList >> includesTask: aTask [

	^ self tasks includes: aTask
]

{ #category : #testing }
CrAbstractList >> isArchived [

	^ false
]

{ #category : #testing }
CrAbstractList >> isEditable [

	^ self type isEditable
]

{ #category : #testing }
CrAbstractList >> isVirtual [

	^ false
]

{ #category : #testing }
CrAbstractList >> isVisible [
	
	^ self type isVisible
]

{ #category : #accessing }
CrAbstractList >> name [

	^ self subclassResponsibility
]

{ #category : #accessing }
CrAbstractList >> pendingTasks [

	^ self tasks reject: #isDone
]

{ #category : #accessing }
CrAbstractList >> pendingTasksSize [

	^ self pendingTasks size
]

{ #category : #actions }
CrAbstractList >> saveTask: aTask [ 

	self subclassResponsibility
]

{ #category : #testing }
CrAbstractList >> showsCompletion [

	^ self type showsCompletion
]

{ #category : #testing }
CrAbstractList >> showsFocus [

	^ self type showsFocus
]

{ #category : #testing }
CrAbstractList >> showsPendingSize [

	^ self type showsPendingSize
]

{ #category : #accessing }
CrAbstractList >> summaryString [
	| tasks tasksSize doneTasksSize pendingTasksSize |
	
	tasks := self tasks.
	
	tasksSize := tasks size.
	tasksSize = 0 ifTrue: [ ^ 'No tasks.' ].
	
	doneTasksSize := (tasks select: [ :each | each isDone ]) size.
	doneTasksSize = tasksSize ifTrue: [ ^ 'No pending tasks.' ]. 
	
	pendingTasksSize := tasksSize - doneTasksSize.
	
	^ String streamContents: [ :stream |
		stream << ('{1} pending task{2}' format: { 
			pendingTasksSize. 
			pendingTasksSize > 1 ifTrue: [ 's' ] ifFalse: [ '' ] }).
		(self showsCompletion and: [ doneTasksSize > 0]) ifTrue: [ 
			stream << ', '.
			stream << ('{1} completed' format: { doneTasksSize }) ].
		stream << '.' ]
]

{ #category : #accessing }
CrAbstractList >> tasks [

	^ self subclassResponsibility
]

{ #category : #accessing }
CrAbstractList >> tasksSize [

	^ self tasks size
]

{ #category : #accessing }
CrAbstractList >> type [

	^ self subclassResponsibility
]
