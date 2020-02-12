Class {
	#name : #CrSettingsPanel,
	#superclass : #SpPresenter,
	#category : #'Crono-View-Todo-Preferences'
}

{ #category : #accessing }
CrSettingsPanel class >> allSettings [

	^ (self allSubclasses 
		sorted: [ :settingClass | settingClass order ] ascending)
		collect: [ :each | each new ]
]

{ #category : #accessing }
CrSettingsPanel class >> order [
	"To the bottom, by default"
	^ 9999
]

{ #category : #accessing }
CrSettingsPanel >> title [

	^ self subclassResponsibility
]
