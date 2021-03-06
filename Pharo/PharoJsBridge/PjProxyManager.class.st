Class {
	#name : #PjProxyManager,
	#superclass : #Object,
	#classVars : [
		'currentId',
		'proxies'
	],
	#pools : [
		'PjNodeGlobals'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #'instance creation' }
PjProxyManager class >> atGlobalVarName: globalId put: anObject [
	global at: globalId put: anObject
]

{ #category : #'instance creation' }
PjProxyManager class >> atProxyId: aProxyId put: anObject [
	global at: aProxyId put: anObject.
	self proxies at: aProxyId put: anObject.
	anObject instVarNamed: '$_jsName' putHidden: aProxyId
]

{ #category : #'default instance' }
PjProxyManager class >> deleteGlobalVarNamed: aVarName [
	<javascript:
	'var obj = global[aVarName];
	if (obj) {
		obj.$_jsName = undefined;
		if (aVarName)
			delete global[aVarName]
	}'>
]

{ #category : #'instance creation' }
PjProxyManager class >> ensureObjectRegistered: anObject [
	| aProxyId |
	aProxyId := anObject instVarNamed: '$_jsName'.
	aProxyId
		ifNil: [ aProxyId := '$_' , PjProxyManager nextId asString.
			self atProxyId: aProxyId put: anObject ].
	^ aProxyId
]

{ #category : #'instance creation' }
PjProxyManager class >> ensureOidOnObject: anObject [
	^ (self getOidFrom: anObject)
		ifNil: [ | oid |
			oid := PjProxyManager nextOid.
			self setOid: oid on: anObject.
			oid ]
]

{ #category : #'instance creation' }
PjProxyManager class >> getOidFrom: anObject [
	^anObject instVarNamed: self oidInstVarName
]

{ #category : #'instance creation' }
PjProxyManager class >> makeBlockClosureProxy: withThis stopPropagation: stop for: webSocketDelegate [
	"<jsGenerator: #makeBlockClosureProxy_stopPropagation_jsGenerator:>"

	<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	| blockClosure proxyId |
	proxyId := '$_' , self nextId asString.
	blockClosure := [ :ev | 
	| cbPayload target cb |
	stop
		ifTrue: [ ev stopPropagation ].
	target := withThis
		ifFalse: [ nil ]
		ifTrue: [ ev target ifNil: [ ev sourceElement ] ].
	cbPayload := {proxyId.
	ev proxyResponse.
	target proxyResponse}.
	cb := {('cb' -> cbPayload)} asDictionary.
	webSocketDelegate doCallBack: (JSON stringify: cb).
	true ].
	blockClosure instVarNamed: '$PjRefCount' put: 0.
	self atProxyId: proxyId put: blockClosure.
	^ blockClosure
]

{ #category : #'instance creation' }
PjProxyManager class >> nextGlobalVarName [
	^ '$_' , self nextIdNumber asString
]

{ #category : #'instance creation' }
PjProxyManager class >> nextId [
	currentId := currentId ifNil: [ 1 ] ifNotNil: [ :id | id + 1 ].
	^ currentId
]

{ #category : #'instance creation' }
PjProxyManager class >> nextIdNumber [
	currentId := currentId ifNil: [ 1 ] ifNotNil: [ :id | id + 1 ].
	^ currentId
]

{ #category : #'instance creation' }
PjProxyManager class >> nextOid [
	^ '$_' , self nextIdNumber asString
]

{ #category : #'default instance' }
PjProxyManager class >> oidInstVarName [
	^ '$_oid'
]

{ #category : #'instance creation' }
PjProxyManager class >> proxies [
	proxies ifNil: [ proxies := Dictionary new].
	^ proxies
]

{ #category : #'instance creation' }
PjProxyManager class >> setOid: anOid on: anObject [
	anObject instVarNamed: self oidInstVarName putHidden: anOid
]
