"
I'm a command to change the done status of a task. 

"
Class {
	#name : #CrTodoTaskChangeDoneStatusCommand,
	#superclass : #CrTodoTaskCommand,
	#instVars : [
		'state'
	],
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #converting }
CrTodoTaskChangeDoneStatusCommand >> asSpecCommand [

	self error: 'This command does not has an UI'
]

{ #category : #executing }
CrTodoTaskChangeDoneStatusCommand >> execute [ 

	self task isDone = self state ifTrue: [ ^ self ].
	
	self task changeStatusTo: self state.
	self application notificationCenter 
		notify: (CrTaskChangedNotification newTask: self task).	
	self task isFocused ifTrue: [ 
		self application notificationCenter 
			notify: (CrVirtualListTaskChangedNotification 
				newList: CrTodoList focus
				task: self task) ]
]

{ #category : #accessing }
CrTodoTaskChangeDoneStatusCommand >> state [
	^ state
]

{ #category : #accessing }
CrTodoTaskChangeDoneStatusCommand >> state: anObject [
	state := anObject
]
