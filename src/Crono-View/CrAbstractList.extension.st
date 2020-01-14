Extension { #name : #CrAbstractList }

{ #category : #'*Crono-View' }
CrAbstractList >> iconOn: anApplication [

	^ self iconName ifNotNil: [ 
		anApplication iconNamed: self iconName ]
]
