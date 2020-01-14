Class {
	#name : #CrTodoTaskCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #accessing }
CrTodoTaskCommand >> task [

	^ context activeTask
]
