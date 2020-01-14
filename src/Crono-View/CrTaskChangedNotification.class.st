Class {
	#name : #CrTaskChangedNotification,
	#superclass : #CrTaskNotification,
	#category : #'Crono-View-Todo-Notifications'
}

{ #category : #accessing }
CrTaskChangedNotification class >> receiverSelector [
	
	^ #noteTaskChanged:
]
