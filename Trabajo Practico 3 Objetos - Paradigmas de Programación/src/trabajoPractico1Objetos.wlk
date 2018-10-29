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

object espadaDelDestino inherits Espada{
}

object mascaraOscura inherits Mascara(1,3,0){}

object refuerzoNulo{
	method unidadesDeLucha(personaje){
		return 0
	}
	method pesoAgregado(personaje){
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
	method pesoAgregado(personaje){
		return 0
	}
	method precioRefuerzo(armadura,personaje){
		return armadura.valorBase()
	}
}

object feria{
	var artefactos = []
	var hechizos = []
	var oro
	
	method agregarHechizo(nuevoHechizo){
		hechizos.add(nuevoHechizo)
	}
	method agregarArtefacto(nuevoArtefacto){
		artefactos.add(nuevoArtefacto)
	}
	method canjearHechizoPreferido(personaje,elHechizo){
		if (hechizos.contains(elHechizo)){
			if (personaje.puedeCanjear(elHechizo)){
				self.realizarCanjeHechizo(personaje,elHechizo)
			}else{
				if(personaje.puedeComprar(elHechizo)){
					personaje.perderOro(elHechizo.precio(personaje) - personaje.hechizoPreferido().precio(personaje)/2)
					self.realizarCanjeHechizo(personaje,elHechizo)
					oro = oro + elHechizo.precio(personaje) - personaje.hechizoPreferido().precio(personaje)/2
				}else{
					throw new DineroInsuficienteException("Excepcion de feria: Dinero insuficiente.")
				}
			}
		}else{
			throw new NoSeEncuentraElHechizoException("Excepcion de feria: No se encuentra el hechizo pedido.")
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
				throw new DineroInsuficienteException("Excepcion de feria: Dinero insuficiente.")
			}
		}else{
			throw new NoSeEncuentraElArtefactoException("Excepcion de feria: No se encuentra el artefacto pedido.")
		}
	}
	method realizarVentaArtefacto(personaje,elArtefacto){
		artefactos.remove(elArtefacto)
		personaje.agregarArtefacto(elArtefacto)
	}
}

object hechizoComercial inherits Hechizo{
	var nombre = "el hechizo comercial"
	var porcentaje = 20
	var multiplicador = 2
	
	override method poder(){
		return nombre.size()*porcentaje/100*multiplicador
	}
	method cambiarPorcentaje(nuevoPorcentaje){
		porcentaje = nuevoPorcentaje
	}
	method cambiarMultiplicador(nuevoMultiplicador){
		multiplicador = nuevoMultiplicador
	}
}

object facil{
	
	method multiplicador(){
		return 1
	}
}

object moderado{
	
	method multiplicador(){
		return 2
	}
}

object dificil{
	
	method multiplicador(){
		return 4
	}
}

class Comerciante{
	var tipoComerciante
	var comision
	var artefactos
	var oro = 0
	
	constructor(tipo,nuevosArtefactos,nuevaComision){
		tipoComerciante = tipo
		comision = nuevaComision
		artefactos = nuevosArtefactos
	}
	
	method venderArtefacto(personaje,elArtefacto){
		if (artefactos.contains(elArtefacto)){
			if (personaje.oro()>=self.precioTotalVenta(elArtefacto,personaje)){
				self.realizarVentaArtefacto(personaje,elArtefacto)
			}else{
				throw new DineroInsuficienteException("Excepcion de comerciante: Dinero insuficiente.")
			}
		}else{
			throw new NoSeEncuentraElArtefactoException("Excepcion de comerciante: No se encuentra el artefacto pedido.")
		}
	}
	method precioTotalVenta(elArtefacto,personaje){
		return elArtefacto.precio(personaje)+tipoComerciante.valorAgregado(self,elArtefacto)
	}
	method realizarVentaArtefacto(personaje,elArtefacto){
		artefactos.remove(elArtefacto)
		personaje.agregarArtefacto(elArtefacto)
		personaje.perderOro(self.precioTotalVenta(elArtefacto,personaje))
		self.ganarOro(self.precioTotalVenta(elArtefacto,personaje))
	}
	method ganarOro(cantidad){
		oro+=cantidad
	}
	method agregarArtefacto(nuevoArtefacto){
		artefactos.add(nuevoArtefacto)
	}
	method valorAgregado(){
		return tipoComerciante.valorAgregado(self)
	}
	method tipoComerciante(tipo){
		tipoComerciante = tipo
	}
	method comision(nuevaComision){
		comision = nuevaComision
	}
	method comision(){
		return comision
	}
	method cambiarSituacionImpositiva(){
		tipoComerciante.cambiarSituacionImpositiva(self)
	}
}
object independiente{
	method valorAgregado(comerciante,producto){
		return comerciante.comision()*producto.precio()
	}
	method cambiarSituacionImpositiva(comerciante){
		comerciante.comision(comerciante.comision()*2)
		if(comerciante.comision()>21){
			comerciante.tipoComerciante(registrado)
		}
	}
}
object registrado{
	method valorAgregado(comerciante,producto){
		return producto.precio()*21/100
	}
	method cambiarSituacionImpositiva(comerciante){
		comerciante.tipoComerciante(impositivo)
	}
}

object impositivo{
	var minimoNoImponible
	
	method minimoNoImponible(valor){
		minimoNoImponible = valor
	}
	method valorAgregado(comerciante,producto){
		if(producto.precio()<minimoNoImponible){
			return 0 
		}else{
			return producto.precio()*35/100
		}
	}
	method cambiarSituacionImpositiva(comerciante){
	}
}