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

	^ (IceRepository registry detect: [ :each | each name = 'worklog' ]) location
]

{ #category : #accessing }
CrDevelopmentPaths >> resourcesDir [

	^ self repositoryDir / 'resources'
]
