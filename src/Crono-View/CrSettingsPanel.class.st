Class {
	#name : #CrSettingsPanel,
	#superclass : #CrPresenter,
	#category : #'Crono-View-Todo-Settings'
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
CrSettingsPanel >> settings [

	^ self application settings
]

{ #category : #accessing }
CrSettingsPanel >> title [

	^ self subclassResponsibility
]
