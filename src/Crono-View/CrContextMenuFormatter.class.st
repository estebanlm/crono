"
I'm a visitor to make some changes in commands to prepare them to be shown as a context menu.
This is needed this because commander cannot differentiate between a command to be shown in a toolbar and in a menu. 

"
Class {
	#name : #CrContextMenuFormatter,
	#superclass : #CmVisitor,
	#category : #'Crono-View-Base'
}

{ #category : #visiting }
CrContextMenuFormatter >> visitCommand: aCmCommand [

	aCmCommand iconName: nil
]
