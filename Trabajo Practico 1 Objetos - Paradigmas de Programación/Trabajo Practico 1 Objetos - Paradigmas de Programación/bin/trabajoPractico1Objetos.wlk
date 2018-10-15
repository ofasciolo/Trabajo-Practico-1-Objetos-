import Clases.*

object fuerzaOscura{
	var valor = 5
	method valor(){
		return valor
	}
	method valor(suceso){
		valor += suceso
	}
	method eclipse(){
		valor *= 2
	}
	method unidadesDeLucha(personaje){
		if(valor/2>4){
			return valor/2
		}else{
			return 4
		}
	}
}

//object rolando inherits Personaje(hechizoBasico,[]){}

//object espectroMalefico inherits Logo("Espectro Malefico",1){}

//object hechizoBasico inherits Hechizo{}

object espadaDelDestino inherits Espada{
}

object collarDivino{
	var perlas
	
	method perlas(cantidadPerlas){
		perlas = cantidadPerlas
	}
	method unidadesDeLucha(personaje){
		return perlas
	}
	method precio(personaje){
		return perlas*2
	}
}

object mascaraOscura inherits Mascara(1){}

object refuerzoNulo{
	method unidadesDeLucha(personaje){
		return 0
	}
	method precioRefuerzo(armadura,personaje){
		return 2
	}
}

object bendicion{
	method unidadesDeLucha(personaje){
		return personaje.nivelHechiceria()
	}
	method precioRefuerzo(armadura,personaje){
		return armadura.valorBase()
	}
}

object espejo{
	method unidadesDeLucha(personaje){
		if (personaje.artefactos()==[self]){
			return 0
		}else{
			return personaje.artefactos().filter({artefacto=>artefacto!=self}).map({artefacto=>artefacto.unidadesDeLucha(personaje)}).max()
		}
	}
	method precio(personaje){
		return 90
	}
}


object feria{
	var artefactos=[]
	var hechizos=[] 
	var oro=0
	
	method agregarHechizo(nuevoHechizo){
		hechizos += [nuevoHechizo]
	}
	method agregarArtefacto(nuevoArtefacto){
		artefactos += [nuevoArtefacto]
	}
	method canjearHechizoPreferido(personaje,elHechizo){
		if (hechizos.contains(elHechizo)){
			if ((personaje.hechizoPreferido().precio(personaje)/2)>=elHechizo.precio(personaje)){
				self.realizarCanjeHechizo(personaje,elHechizo)
			}else{
				if(personaje.hechizoPreferido().precio(personaje)/2 + personaje.oro()>=elHechizo.precio(personaje)){
					personaje.perderOro(elHechizo.precio(personaje) - personaje.hechizoPreferido().precio(personaje)/2)
					self.realizarCanjeHechizo(personaje,elHechizo)
					oro = oro + elHechizo.precio(personaje) - personaje.hechizoPreferido().precio(personaje)/2
				}else{
					throw new UserException("Excepcion de feria: Dinero insuficiente.")
				}
			}
		}else{
			throw new UserException("Excepcion de feria: No se encuentra el hechizo pedido.")
		}
	}
	method realizarCanjeHechizo(personaje,elHechizo){
		self.agregarHechizo(personaje.hechizoPreferido())
		personaje.hechizoPreferido(elHechizo)
	}
	method venderArtefacto(personaje,elArtefacto){
		if (artefactos.contains(elArtefacto)){
			if (personaje.oro()>=elArtefacto.precio(personaje)){
				self.realizarVentaArtefacto(personaje,elArtefacto)
				personaje.perderOro(elArtefacto.precio(personaje))
			}else{
				throw new UserException("Excepcion de feria: Dinero insuficiente.")
			}
		}else{
			throw new UserException("Excepcion de feria: No se encuentra el artefacto pedido.")
		}
	}
	method realizarVentaArtefacto(personaje,elArtefacto){
		artefactos.remove(elArtefacto)
		personaje.agregarArtefacto(elArtefacto)
	}
}



