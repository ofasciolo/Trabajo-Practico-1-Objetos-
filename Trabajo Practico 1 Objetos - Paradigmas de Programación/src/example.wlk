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
	method unidadesDeLucha(mensajero){
		if(valor/2>4){
			return valor/2
		}else{
			return 4
		}
	}
}

object rolando{
	var hechizoPreferido 
	var artefactos = []
	var valorBaseLucha = 1 

	method nivelHechiceria(){
		return 3*hechizoPreferido.poder()+fuerzaOscura.valor()
	}
	method artefactos(){
		return artefactos
	}
	method hechizoPreferido(hechizo){
		hechizoPreferido = hechizo
	}	
	method seCreePoderoso(){
		return hechizoPreferido.hechizoPoderoso()
	}
	method valorBaseLucha(valor){
		valorBaseLucha = valor
	}
	method agregarArtefacto(artefacto){
		artefactos.add(artefacto)
	}
	method removerArtefacto(artefacto){
		artefactos.remove(artefacto)
	}
	method removerTodosLosArtefactos(){
		artefactos.clear()
	}
	method mayorHabilidadDeLucha(){
		return self.habilidadLucha() > self.nivelHechiceria()
	}
	method habilidadLucha(){
		return valorBaseLucha + artefactos.map({artefacto=>artefacto.unidadesDeLucha(self)}).sum()
	}
	method estaCargado(){
		return artefactos.size()>=5
	}
}

object espectroMalefico{
	var nombre = "Espectro Malefico"
	method hechizoPoderoso(){
		return self.poder()>15
	}
	method poder(){
		return nombre.size()
	}
	method cambiarNombre(nuevoNombre){
		nombre = nuevoNombre
	}
	method unidadesDeLucha(mensajero){
		return self.poder()
	}
	method agregarAListaHechizos(hechizo){
		
	}
}

object hechizoBasico{
	method poder(){
		return 10
	}
	method hechizoPoderoso(){
		return self.poder()>15
	}
	method cambiarNombre(){
		
	}
	method unidadesDeLucha(mensajero){
		return self.poder()
	}
	method agregarAListaHechizos(hechizo){
		
	}
}

object espadaDelDestino{
	method unidadesDeLucha(mensajero){
		return 3
	}
	method perlas(cantidadPerlas){
		
	}
	method refuezo(nuevoRefuerzo){
		
	}
}

object collarDivino{
	var perlas
	
	method perlas(cantidadPerlas){
		perlas = cantidadPerlas
	}
	method unidadesDeLucha(mensajero){
		return perlas
	}
	method refuezo(nuevoRefuerzo){
		
	}
}

object mascaraOscura{
	
	method unidadesDeLucha(mensajero){
		return fuerzaOscura.unidadesDeLucha(mensajero)
	}
	method perlas(cantidadPerlas){
		
	}
	method refuezo(nuevoRefuerzo){
		
	}
}

object armadura{
	var refuerzo = refuerzoNulo
	method unidadesDeLucha(mensajero){
		return 2 + refuerzo.unidadesDeLucha(mensajero)
	}
	method refuerzo(nuevoRefuerzo){
		refuerzo = nuevoRefuerzo
	}
}

object refuerzoNulo{
	method unidadesDeLucha(mensajero){
		return 0
	}
}

object cotaDeMalla{
	method unidadesDeLucha(mensajero){
		return 1
	}
}

object bendicion{
	method unidadesDeLucha(mensajero){
		return mensajero.nivelHechiceria()
	}
}

object espejo{
	method unidadesDeLucha(mensajero){
		if (mensajero==self || mensajero.artefactos()==[self]){
			return 0
		}else{
			return mensajero.artefactos().max({artefacto=>artefacto.unidadesDeLucha(self)})
		}
	}
	method perlas(cantidadPerlas){
		
	}
	method refuezo(nuevoRefuerzo){
		
	}
}

object libroDeHechizos{
	var listaHechizos = []
	method poder(){
		return listaHechizos.filter({hechizo=>hechizo.hechizoPoderoso()}).sum({hechizo=>hechizo.poder()})
	}
	method agregarAListaHechizos(hechizo){
		listaHechizos.add(hechizo)
	}
	method hechizoPoderoso(){
		
	}
	method cambiarNombre(){
		
	}
	method unidadesDeLucha(mensajero){
		
	}
	
}



