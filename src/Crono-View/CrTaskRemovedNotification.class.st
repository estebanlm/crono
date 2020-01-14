Class {
	#name : #CrTaskRemovedNotification,
	#superclass : #CrTaskNotification,
	#category : #'Crono-View-Todo-Notifications'
}

{ #category : #accessing }
CrTaskRemovedNotification class >> receiverSelector [
	
	^ #noteTaskRemoved:
]
