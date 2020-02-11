Class {
	#name : #CrDevelopmentPaths,
	#superclass : #CrResourcePaths,
	#category : #'Crono-Model-Base'
}

{ #category : #testing }
CrDevelopmentPaths class >> isActive [

	^ CrModelApplication isDevelopment
]

{ #category : #accessing }
CrDevelopmentPaths >> repositoryDir [

	^ (IceRepository registry detect: [ :each | each name = 'crono' ]) location
]

{ #category : #accessing }
CrDevelopmentPaths >> resourcesDirectory [

	^ self repositoryDir / 'resources'
]
