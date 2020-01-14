Class {
	#name : #CrTaskAddedNotification,
	#superclass : #CrTaskNotification,
	#category : #'Crono-View-Todo-Notifications'
}

{ #category : #accessing }
CrTaskAddedNotification class >> receiverSelector [
	
	^ #noteTaskAdded:
]
