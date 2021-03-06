Class {
	#name : #PjToolsTest,
	#superclass : #TestCase,
	#category : #'PharoJsTools-Tests'
}

{ #category : #testing }
PjToolsTest >> testClassAbstract [
	self assert: PjApplication isAbstract.
	self deny: PjFileBasedWebApp isAbstract.
	self deny: PjWebApplication isAbstract.
	self deny: PjNodeApplication isAbstract.
	self assert: PjToolsTest1 subclassResponsibilitySet equals: #(m1 m2) asSet.
	self assert: PjToolsTest1 classSubclassResponsibilitySet equals: #(c1) asSet.
	self assert: PjToolsTest1 isAbstract.
	self assert: PjToolsTest2 subclassResponsibilitySet equals: #(m2) asSet.
	self assert: PjToolsTest2 classSubclassResponsibilitySet isEmpty.
	self assert: PjToolsTest2 isAbstract.
	self assert: PjToolsTest3 subclassResponsibilitySet isEmpty.
	self assert: PjToolsTest3 classSubclassResponsibilitySet isEmpty.
	self deny: PjToolsTest3 isAbstract.
	self assert: PjToolsTest2b subclassResponsibilitySet isEmpty.
	self assert: PjToolsTest2b classSubclassResponsibilitySet equals: #(c1) asSet.
	self assert: PjToolsTest2b isAbstract.

	
]
