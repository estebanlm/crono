Class {
	#name : #CrResourcePaths,
	#superclass : #Object,
	#category : #'Crono-Model-Base'
}

{ #category : #testing }
CrResourcePaths class >> isActive [

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
CrResourcePaths class >> newActive [

	^ (self allSubclasses detect: #isActive) new
		
]

{ #category : #accessing }
CrResourcePaths >> cronoRepositoryReference [

	^ FileLocator imageDirectory / 'crono.db'
]

{ #category : #accessing }
CrResourcePaths >> iconsDir [

	^ self resourcesDir / 'icons' / '16'
]

{ #category : #accessing }
CrResourcePaths >> resourcesDir [

	^ FileLocator imageDirectory
]

{ #category : #accessing }
CrResourcePaths >> todoRepositoryReference [

	^ FileLocator imageDirectory / 'todo.db'
]
