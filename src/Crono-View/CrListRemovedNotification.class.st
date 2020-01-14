Class {
	#name : #CrListRemovedNotification,
	#superclass : #CrListNotification,
	#category : #'Crono-View-Todo-Notifications'
}

{ #category : #accessing }
CrListRemovedNotification class >> receiverSelector [

	^ #noteListRemoved:
]
