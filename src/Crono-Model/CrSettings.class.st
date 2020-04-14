Class {
	#name : #CrSettings,
	#superclass : #Object,
	#instVars : [
		'pomodoroDuration'
	],
	#classVars : [
		'Current',
		'Development'
	],
	#category : #'Crono-Model-Base'
}

{ #category : #accessing }
CrSettings >> pomodoroDuration [

	^ pomodoroDuration ifNil: [ 25 minutes ]
]
