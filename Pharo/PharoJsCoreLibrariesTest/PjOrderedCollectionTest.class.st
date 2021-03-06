Class {
	#name : #PjOrderedCollectionTest,
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'collection'
	],
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #testing }
PjOrderedCollectionTest >> setUp [
	super setUp.
	collection := self evalBlock: [ OrderedCollection new ]
]

{ #category : #testing }
PjOrderedCollectionTest >> testInsertElementBeforeFirstOne [
	collection addAll: #(1 2 3).
	collection insert: 0 before: 1.
	self assert: collection size equals: 4.
	(0 to: 3) withIndexDo: [ : expectedElement : index |
		self assert: (collection at: index) equals: expectedElement
	]
]

{ #category : #testing }
PjOrderedCollectionTest >> testJoin [
	| temp |
	collection addAll: #(4 5).
	temp := collection join: #((1 2 3) (6 7) (3 2)).
	self assert: collection size equals: 2.
	self assert: temp size equals: 11.
	#(1 2 3 4 5 6 7 4 5 3 2) withIndexDo: [ : expectedElement : index |
		self assert: (temp at: index) equals: expectedElement
	]
]

{ #category : #testing }
PjOrderedCollectionTest >> testRemoveAll [
	collection addAll: #(1 2 3 4 5).
	collection removeAll: #(1 5).
	self assert: collection size equals: 3.
	#(2 3 4) withIndexDo: [ : expectedElement : index |
		self assert: (collection at: index) equals: expectedElement
	].
	collection removeAll.
	self assert: collection isEmpty.
]
