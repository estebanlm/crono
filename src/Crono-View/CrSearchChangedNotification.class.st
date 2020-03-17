Class {
	#name : #CrSearchChangedNotification,
	#superclass : #CrNotification,
	#category : #'Crono-View-Todo-Notifications'
}

{ #category : #accessing }
CrSearchChangedNotification class >> receiverSelector [

	^ #noteSearchChanged:
]
