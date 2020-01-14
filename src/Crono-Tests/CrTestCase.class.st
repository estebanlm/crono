Class {
	#name : #CrTestCase,
	#superclass : #TestCase,
	#category : #'Crono-Tests'
}

{ #category : #testing }
CrTestCase class >> isAbstract [

	^ self = CrTestCase
]

{ #category : #running }
CrTestCase >> runCase [
	| oldApplication oldModelApplication |

	oldApplication := CrApplication current.
	oldModelApplication := CrModelApplication current.
	CrApplication setCurrent: CrApplicationForTest new.
	CrModelApplication setCurrent: CrModelApplicationForTest new.
	[ super runCase ]
	ensure: [
		CrModelApplication setCurrent: oldModelApplication.
		CrApplication setCurrent: oldApplication ]
]
