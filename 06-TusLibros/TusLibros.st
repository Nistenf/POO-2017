!classDefinition: #TusLibrosTests category: #TusLibros!
TestCase subclass: #TusLibrosTests
	instanceVariableNames: 'catalogoDeLibros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 20:26:37'!
setUp
	catalogoDeLibros _ Dictionary newFromPairs: { 9780201136883. 300 }! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 21:05:50'!
test01siCreoUnCarritoEstaVacio
	|nuevoCarrito|
	nuevoCarrito _ Carrito createWithCatalog: catalogoDeLibros.
	
	self assert: [nuevoCarrito isEmpty]! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 20:27:24'!
test02siAgregoLibroElCarritoLoContiene
	|nuevoCarrito|
	nuevoCarrito _ Carrito createWithCatalog: catalogoDeLibros.
	
	nuevoCarrito agregarLibro: 9780201136883.
	
	self deny: nuevoCarrito isEmpty.
	self assert: (nuevoCarrito includes: 9780201136883)! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 20:27:33'!
test03siAgregoDosLibrosIgualesElCarritoContieneAAmbos
	|nuevoCarrito|
	nuevoCarrito _ Carrito createWithCatalog: catalogoDeLibros.
	
	nuevoCarrito agregarLibro: 9780201136883.
	nuevoCarrito agregarLibro: 9780201136883.
	
	self deny: nuevoCarrito isEmpty.
	self assert: ((nuevoCarrito amountOf: 9780201136883) = 2)! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 20:27:42'!
test04siRemuevoUnaUnidadDeLibroContenidoSuCantidadSeReduceEnUno
	|nuevoCarrito|
	nuevoCarrito _ Carrito createWithCatalog: catalogoDeLibros.
	
	nuevoCarrito agregar: 20000 libro: 9780201136883.
	nuevoCarrito removerLibro: 9780201136883.
	
	self deny: nuevoCarrito isEmpty.
	self assert: ((nuevoCarrito amountOf: 9780201136883) = 19999)! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 20:27:50'!
test05siRemuevoLibrosQueNoEstanContenidosTiraError
	|nuevoCarrito libroARemover cantidadAgregada |
	nuevoCarrito _ Carrito createWithCatalog: catalogoDeLibros.
	libroARemover _ 9780201136883.
	cantidadAgregada _ 20000.
	nuevoCarrito agregar: cantidadAgregada libro: libroARemover.

	self should: [	nuevoCarrito remover: 100000000000000000 libro: libroARemover. ] 
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert:  error messageText = Carrito errorNotEnoughBooks. self assert: (nuevoCarrito amountOf: libroARemover) = cantidadAgregada ]
	! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 20:27:58'!
test06siAgregoLibroQueNoEsDeEstaEditorialTiraError
	|nuevoCarrito|
	nuevoCarrito _ Carrito createWithCatalog: catalogoDeLibros.

	self should: [	nuevoCarrito agregar: 20000 libro: 9780596009205. ] 
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: error messageText = Carrito errorBookArentBelongToUs. self assert: nuevoCarrito isEmpty ]
	! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 20:28:05'!
test07siModificoLosContentsQueDevuelveElCarritoElMismoQuedaIgual
	| unLibro unCarrito contenidoDevuelto  |
	unLibro _ 9780201136883.
	unCarrito _ Carrito createWithCatalog: catalogoDeLibros.

	unCarrito agregarLibro: unLibro.
	contenidoDevuelto _ unCarrito contents.
	
	contenidoDevuelto remove: unLibro.
	
	self assert: (unCarrito includes: unLibro ).! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 20:28:09'!
test08noSePuedenAgregarCeroLibrosAUnCarrito
	| unLibro unCarrito  |
	unLibro _ 9780201136883.
	unCarrito _ Carrito createWithCatalog: catalogoDeLibros.

	
	self should: [unCarrito agregar: 0 libro: unLibro ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | anError messageText = Carrito errorInvalidAmountToAdd].


	! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 20:28:13'!
test09noSePuedeAgregarCantidadNegativaDeLibrosAUnCarrito
	| unLibro unCarrito  |
	unLibro _ 9780201136883.
	unCarrito _ Carrito createWithCatalog: catalogoDeLibros.

	
	self should: [unCarrito agregar: -489418914 libro: unLibro ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | anError messageText = Carrito errorInvalidAmountToAdd].


	! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 20:38:26'!
test10noSePuedeCheckOutearConTarjetaVencida
	| unLibro unCarrito unCashier |
	unLibro _ 9780201136883.
	unCarrito _ Carrito createWithCatalog: catalogoDeLibros.

	unCarrito agregarLibro: unLibro.
	
	unCashier _ Cashier new.
	
	self should: [unCashier checkout: unCarrito withCCN: 4523815001478952 andCCED: (GregorianMonthOfYear yearNumber: 2017 monthNumber: 3) andCCO: 'Alan Kay']
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |  self assert: anError messageText = Cashier errorExpiredCreditCard. ].

	

	! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 21:13:36'!
test11siHagoCheckoutDeUnCarritoLaVentaFiguraRegistrada
	| unLibro unCarrito unCashier anExpirationDate aPurchase |
	unLibro _ 9780201136883.
	unCarrito _ Carrito createWithCatalog: catalogoDeLibros.

	unCarrito agregarLibro: unLibro.
	
	unCashier _ Cashier createWith: (MerchantProcessorInterfaceSimulator createWith: [ ]).
	
	anExpirationDate _ GregorianMonthOfYear current next.
		
	aPurchase  _ unCashier checkout: unCarrito withCCN: 4523815001478952 andCCED: anExpirationDate andCCO: 'Alan Kay'.
	
	self assert: (unCashier libroDeVentas detect: [:purchase | purchase == aPurchase] ifFound: [^true] ifNone: [ ^false ] ).! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 21:15:47'!
test12siFallaElCheckOutNoSeRegistraEnElLibroDeVentas
	| unLibro otroLibro unCarrito unCashier anExpirationDate unLibroDeVentas |
	unLibro _ 9780201136883.
	otroLibro _  9780596517748.
	unCarrito _ Carrito createWithCatalog: catalogoDeLibros.
	unLibroDeVentas _ OrderedCollection withAll: { Bag newFrom: {otroLibro }}.

	unCarrito agregarLibro: unLibro.
	
	unCashier _ Cashier new initializeWith: (MerchantProcessorInterfaceSimulator createWith: [ self error: 'cualquier error' ]) and: unLibroDeVentas.
	
	anExpirationDate _ GregorianMonthOfYear current next.
	
	self should: [ unCashier checkout: unCarrito withCCN: 4523815001478952 andCCED: anExpirationDate andCCO: 'Alan Kay'. ]
 	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | self assert: unCashier libroDeVentas = unLibroDeVentas ].
	! !

!TusLibrosTests methodsFor: 'test' stamp: 'ai 6/26/2017 21:23:14'!
test13hacerCheckoutConTarjetaVencidaNoUsaMerchantProcessor
	| unLibro unCarrito unCashier |
	unLibro _ 9780201136883.
	unCarrito _ Carrito createWithCatalog: catalogoDeLibros.

	unCarrito agregarLibro: unLibro.
	
	unCashier _ Cashier createWith: (MerchantProcessorInterfaceSimulator createWith: [ self error: 'Error en el merchant processor.' ]).
	
	self should: [unCashier checkout: unCarrito withCCN: 4523815001478952 andCCED: (GregorianMonthOfYear yearNumber: 2017 monthNumber: 3) andCCO: 'Alan Kay']
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |  self assert: anError messageText = Cashier errorExpiredCreditCard. ].

	

	! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'contents catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'initialization' stamp: 'a 6/22/2017 18:02:30'!
initialize
	self initializeWithCatalog: {9780201136883}
	"Catalogo por defecto para no romper todos los tests"! !

!Carrito methodsFor: 'initialization' stamp: 'ai 6/26/2017 20:31:15'!
initializeWithCatalog: aDictionary
	contents := Bag new .
	catalog := aDictionary.! !


!Carrito methodsFor: 'adding' stamp: 'ai 6/26/2017 20:29:54'!
agregar: cantidadAAgregar libro: isbnNumber 
	
	catalog at: isbnNumber ifAbsent: [^ self error: self class errorBookArentBelongToUs ].
	cantidadAAgregar < 1 ifTrue: [ self error: self class errorInvalidAmountToAdd ]	.
	^ contents add: isbnNumber withOccurrences: cantidadAAgregar .! !

!Carrito methodsFor: 'adding' stamp: 'MC 6/13/2017 17:48:11'!
agregarLibro: isbnNumber 
	self agregar: 1 libro: isbnNumber 	
	! !


!Carrito methodsFor: 'accessing' stamp: 'a 6/22/2017 17:49:25'!
amountOf: isbnNumber
	^contents occurrencesOf: isbnNumber ! !

!Carrito methodsFor: 'accessing' stamp: 'a 6/22/2017 17:57:21'!
contents
	^ Bag withAll: contents.! !

!Carrito methodsFor: 'accessing' stamp: 'a 6/22/2017 17:49:29'!
includes:  isbnNumber 
	 ^ contents includes: isbnNumber .! !

!Carrito methodsFor: 'accessing' stamp: 'a 6/22/2017 17:49:34'!
isEmpty
	^contents isEmpty ! !

!Carrito methodsFor: 'accessing' stamp: 'ai 6/26/2017 20:33:39'!
totalCost
	contents inject: 0 into: [:subTotal :next | subTotal + (catalog at: next)]! !


!Carrito methodsFor: 'removing' stamp: 'a 6/22/2017 17:49:46'!
remover: cantidadARemover libro: isbnNumber
	(contents occurrencesOf: isbnNumber) < cantidadARemover ifTrue: [ self error: self class errorNotEnoughBooks ].
	cantidadARemover timesRepeat: [ contents remove: isbnNumber ].! !

!Carrito methodsFor: 'removing' stamp: 'MC 6/13/2017 18:07:57'!
removerLibro: isbnNumber
	self remover: 1 libro: isbnNumber ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #TusLibros!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'error' stamp: 'MC 6/13/2017 18:38:24'!
errorBookArentBelongToUs
	^ 'El libro no es de la editorial'! !

!Carrito class methodsFor: 'error' stamp: 'a 6/22/2017 18:23:21'!
errorInvalidAmountToAdd
	^ 'No se puede agregar menos de un objeto al carrito'.! !

!Carrito class methodsFor: 'error' stamp: 'MC 6/13/2017 18:09:22'!
errorNotEnoughBooks
	^ 'No podes remover mas libros que los que tenes'! !


!Carrito class methodsFor: 'instance creation' stamp: 'ai 6/26/2017 20:15:37'!
createWithCatalog: aDicionary
	^ self new initializeWithCatalog: aDicionary.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessorInterface libroDeVentas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'ai 6/26/2017 21:03:23'!
initializeWith: aMerchantProcessorInterface and: unLibroDeVentas
	merchantProcessorInterface _ aMerchantProcessorInterface.
	libroDeVentas _ unLibroDeVentas.! !


!Cashier methodsFor: 'accessing' stamp: 'ai 6/26/2017 21:05:32'!
libroDeVentas
	^ OrderedCollection withAll: libroDeVentas contents.! !


!Cashier methodsFor: 'checkout' stamp: 'ai 6/26/2017 20:55:54'!
checkout: aCarrito withCCN: aCreditCardNumber andCCED: anExpirationMonthOfYear andCCO: aName 
	| currentMonthOfYear |

	currentMonthOfYear _ GregorianMonthOfYear current.	
	anExpirationMonthOfYear < currentMonthOfYear ifTrue: [self error: Cashier errorExpiredCreditCard ].
	
	merchantProcessorInterface debit: aCarrito totalCost withCCN: aCreditCardNumber andCCED: anExpirationMonthOfYear andCCO: aName.
	
	LibroDeVentas add: aCarrito contents.
		
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: 'libroDeVentas'!

!Cashier class methodsFor: 'errors' stamp: 'ai 6/26/2017 21:02:54'!
createWith: aMerchantProcessorInterface
	^self new initializeWith: aMerchantProcessorInterface and: libroDeVentas.! !

!Cashier class methodsFor: 'errors' stamp: 'ai 6/26/2017 19:06:30'!
errorExpiredCreditCard
	^ 'La tarjeta esta vencida'.! !

!Cashier class methodsFor: 'errors' stamp: 'ai 6/26/2017 21:03:54'!
initialize
	libroDeVentas _ OrderedCollection new.! !


!classDefinition: #MerchantProcessorInterface category: #TusLibros!
Object subclass: #MerchantProcessorInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorInterface methodsFor: 'debit' stamp: 'ai 6/26/2017 20:51:43'!
debit: aCarrito withCCN: aSmallInteger andCCED: aGregorianMonthOfYear andCCO: aString 
	self subclassResponsibility.! !


!classDefinition: #MerchantProcessorInterfaceSimulator category: #TusLibros!
MerchantProcessorInterface subclass: #MerchantProcessorInterfaceSimulator
	instanceVariableNames: 'behavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorInterfaceSimulator methodsFor: 'initialization' stamp: 'ai 6/26/2017 20:53:36'!
debit: aCarrito withCCN: aCreditCardNumber andCCED: aGregorianMonthOfYear andCCO: aName 
	^ behavior value.! !

!MerchantProcessorInterfaceSimulator methodsFor: 'initialization' stamp: 'ai 6/26/2017 20:49:26'!
initializeWith: aBlock
	behavior _ aBlock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorInterfaceSimulator class' category: #TusLibros!
MerchantProcessorInterfaceSimulator class
	instanceVariableNames: ''!

!MerchantProcessorInterfaceSimulator class methodsFor: 'instance creation' stamp: 'ai 6/26/2017 20:48:49'!
createWith: aBlock
	^ self new initializeWith: aBlock .! !

Cashier initialize!