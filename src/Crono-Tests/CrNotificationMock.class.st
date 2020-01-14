Class {
	#name : #CrNotificationMock,
	#superclass : #CrNotification,
	#category : #'Crono-Tests'
}

{ #category : #accessing }
CrNotificationMock class >> receiverSelector [ 

	^ #noteMock:
]
