Class {
	#name : #CrDeploymentPaths,
	#superclass : #CrResourcePaths,
	#category : #'Crono-Model-Base'
}

{ #category : #testing }
CrDeploymentPaths class >> isActive [

	^ CrModelApplication isDevelopment not
]
