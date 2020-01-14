Class {
	#name : #CrTodoTaskToggleFocusCommand,
	#superclass : #CrTodoTaskCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoTaskToggleFocusCommand class >> defaultDescription [

	^ 'Focus a task.'
]

{ #category : #default }
CrTodoTaskToggleFocusCommand class >> defaultName [

	^ 'Toggle Focus'
]

{ #category : #default }
CrTodoTaskToggleFocusCommand class >> defaultShortcut [

	^ $f platformMeta
]

{ #category : #executing }
CrTodoTaskToggleFocusCommand >> execute [
	
	self task toggleFocus.
	self application notificationCenter 
		notify: (CrTaskChangedNotification newTask: self task);
		notify: (CrListChangedNotification newList: CrTodoList focus)	
]

{ #category : #accessing }
CrTodoTaskToggleFocusCommand >> name [

	self task ifNil: [ ^ super name ].
	^ self task isFocused
		ifTrue: [ 'Remove Focus' ]
		ifFalse: [ 'Focus' ]
]
