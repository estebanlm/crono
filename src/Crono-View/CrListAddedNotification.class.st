Class {
	#name : #CrListAddedNotification,
	#superclass : #CrListNotification,
	#category : #'Crono-View-Todo-Notifications'
}

{ #category : #accessing }
CrListAddedNotification class >> receiverSelector [

	^ #noteListAdded:
]
