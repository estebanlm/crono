Class {
	#name : #CrApplicationForTest,
	#superclass : #CrApplication,
	#instVars : [
		'model'
	],
	#category : #'Crono-Tests'
}

{ #category : #initialization }
CrApplicationForTest >> initializeBackend [

	GtkApplication ensureRunning.
	self useBackend: #Gtk with: SpGtkConfiguration new
]
