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
CrResourcePaths >> iconsDirectory [

	^ self resourcesDirectory / 'icons' / '16'
]

{ #category : #accessing }
CrResourcePaths >> repositoryReference [

	^ FileLocator imageDirectory / 'todo.edb'
]

{ #category : #accessing }
CrResourcePaths >> resourcesDirectory [

	^ FileLocator imageDirectory
]
