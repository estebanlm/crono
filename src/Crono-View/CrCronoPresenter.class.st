"
I'm a base presenter for the crono subproject.
"
Class {
	#name : #CrCronoPresenter,
	#superclass : #CrPresenter,
	#category : #'Crono-View-Crono'
}

{ #category : #'private factory' }
CrCronoPresenter >> newCrono [

	^ CrCrono newActive
]
