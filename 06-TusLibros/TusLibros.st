!classDefinition: #TusLibrosTests category: #TusLibros!
TestCase subclass: #TusLibrosTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTests methodsFor: 'test' stamp: 'MC 6/13/2017 18:22:53'!
test01siCreoUnCarritoEstaVacio
	|nuevoCarrito|
	nuevoCarrito _ Carrito new.
	
	self assert: [nuevoCarrito isEmpty]! !

!TusLibrosTests methodsFor: 'test' stamp: 'MC 6/13/2017 18:29:18'!
test02siAgregoLibroElCarritoLoContiene
	|nuevoCarrito|
	nuevoCarrito _ Carrito new.
	
	nuevoCarrito agregarLibro: 9780201136883.
	
	self deny: nuevoCarrito isEmpty.
	self assert: (nuevoCarrito includes: 9780201136883)! !

!TusLibrosTests methodsFor: 'test' stamp: 'MC 6/13/2017 18:29:08'!
test03siAgregoDosLibrosIgualesElCarritoContieneAAmbos
	|nuevoCarrito|
	nuevoCarrito _ Carrito new.
	
	nuevoCarrito agregarLibro: 9780201136883.
	nuevoCarrito agregarLibro: 9780201136883.
	
	self deny: nuevoCarrito isEmpty.
	self assert: ((nuevoCarrito amountOf: 9780201136883) = 2)! !

!TusLibrosTests methodsFor: 'test' stamp: 'MC 6/13/2017 18:29:12'!
test04siRemuevoUnaUnidadDeLibroContenidoSuCantidadSeReduceEnUno
	|nuevoCarrito|
	nuevoCarrito _ Carrito new.
	
	nuevoCarrito agregar: 20000 libro: 9780201136883.
	nuevoCarrito removerLibro: 9780201136883.
	
	self deny: nuevoCarrito isEmpty.
	self assert: ((nuevoCarrito amountOf: 9780201136883) = 19999)! !

!TusLibrosTests methodsFor: 'test' stamp: 'MC 6/13/2017 18:33:02'!
test05siRemuevoLibrosQueNoEstanContenidosTiraError
	|nuevoCarrito|
	nuevoCarrito _ Carrito new.
	
	nuevoCarrito agregar: 20000 libro: 9780201136883.

	self should: [	nuevoCarrito remover: 100000000000000000 libro: 9780201136883. ] 
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert:  error messageText = Carrito errorNotEnoughBooks ]
	! !

!TusLibrosTests methodsFor: 'test' stamp: 'MC 6/13/2017 18:31:29'!
test06siAgregoLibroQueNoEsDeEstaEditorialTiraError
	|nuevoCarrito|
	nuevoCarrito _ Carrito new.
	
	

	self should: [	nuevoCarrito agregar: 20000 libro: 9780596009205. ] 
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:error | error = Carrito errorBookArentBelongToUs]
	! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'libros'
	classVariableNames: 'BooksOfThisEditorial'
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'initialization' stamp: 'MC 6/13/2017 17:27:49'!
initialize
	libros := Dictionary new.! !


!Carrito methodsFor: 'adding' stamp: 'MC 6/13/2017 18:37:56'!
agregar: cantidadAAgregar libro: isbnNumber 
	
	(BooksOfThisEditorial includes: isbnNumber) ifFalse: [^ self error: self class errorBookArentBelongToUs ].

	^ libros at: isbnNumber ifPresent: [:cantidadPrevia | libros at: isbnNumber put: cantidadPrevia + cantidadAAgregar ] ifAbsent: [libros at: isbnNumber put: cantidadAAgregar ]! !

!Carrito methodsFor: 'adding' stamp: 'MC 6/13/2017 17:48:11'!
agregarLibro: isbnNumber 
	self agregar: 1 libro: isbnNumber 	
	! !


!Carrito methodsFor: 'accessing' stamp: 'MC 6/13/2017 17:27:19'!
amountOf: isbnNumber
	^libros at: isbnNumber ! !

!Carrito methodsFor: 'accessing' stamp: 'MC 6/13/2017 17:37:11'!
includes:  isbnNumber 
	 libros at: isbnNumber ifPresent: [:cantidad | ^ (cantidad = 0) not ] ifAbsent: [ ^ false ]! !

!Carrito methodsFor: 'accessing' stamp: 'MC 6/13/2017 17:14:58'!
isEmpty
	^libros isEmpty ! !


!Carrito methodsFor: 'removing' stamp: 'MC 6/13/2017 18:11:38'!
remover: cantidadARemover libro: isbnNumber
	libros at: isbnNumber ifPresent: [:cantidadPrevia | cantidadPrevia >= cantidadARemover ifTrue: [ cantidadPrevia = cantidadARemover ifTrue: [libros removeKey: isbnNumber. ^0]  ifFalse: [^ libros at: isbnNumber put: cantidadPrevia - cantidadARemover ]  ] ].
	^ self error: self class errorNotEnoughBooks! !

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

!Carrito class methodsFor: 'error' stamp: 'MC 6/13/2017 18:09:22'!
errorNotEnoughBooks
	^ 'No podes remover mas libros que los que tenes'! !


!Carrito class methodsFor: 'class initialization' stamp: 'MC 6/13/2017 18:41:37'!
initialize
	BooksOfThisEditorial := Set withAll: {9780201136883}
	
! !

Carrito initialize!