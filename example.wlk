//Modelo básico

class Nave {
  var velocidad = 0
  var direccion = 0
  var combustible = 0
  
  method combustible() = combustible
  method velocidad() = velocidad
  method direccion() = direccion

  method acelerar(cuanto) {
    velocidad = (velocidad + cuanto).min(100000)
  }

  method desacelerar(cuanto) {
    velocidad = (velocidad - cuanto).max(0)
  }
  
  method irHaciaElSol() {
    direccion = 10
  }

  method escaparDelSol() {
    direccion = -10
  }

  method ponerseParaleloAlSol() {
    direccion = 0
  }

  method acercarseUnPocoAlSol() {
    direccion = (direccion + 1).min(10)
  }

  method alejarseUnPocoDelSol() {
    direccion = (direccion - 1).max(-10)
  }

  method cargarCombustible(unaCantidad) {
    combustible += unaCantidad
  }

  method descargarCombustible(unaCantidad) {
    combustible -= unaCantidad
  }

  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method estaTranquila() {
    return combustible >= 4000 and velocidad <= 12000
  }

  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }

  method escapar() {}
  method avisar() {}

  method estaDeRelajo() {
    return self.estaTranquila() and self.tienePocaActividad()
  }

  method tienePocaActividad() {
    return true
  }
}

//Distintos tipos de nave

class Navebaliza inherits Nave {
  var colorDeBaliza = "Rojo"
  var cambioDeColor = false

  method colorDeBaliza() = colorDeBaliza
  
  method cambiarColorDeBaliza(colorNuevo) {
    colorDeBaliza = colorNuevo
    cambioDeColor = true
  }

  override method prepararViaje() {
    super()
    self.cambiarColorDeBaliza("Verde")
    self.ponerseParaleloAlSol()
  }

  override method estaTranquila() {
    return super() and colorDeBaliza != "Rojo"
  }

  override method escapar() {
    self.irHaciaElSol()
  }

  override method avisar() {
    self.cambiarColorDeBaliza("Rojo")
  }

  override method estaDeRelajo() {
    return super() and not cambioDeColor
  }
}

class NaveDePasajeros inherits Nave {
  const property cantidadDePasajeros = 0
  var cantidadDeComida = 0
  var cantidadDeBebidas = 0
  
  method cantidadDeComida() = cantidadDeComida
  method cantidadDeBebidas() = cantidadDeBebidas
  

  method cargarComida(unaCantidad) {
    cantidadDeComida += unaCantidad
  }

  method descargarComida(unaCantidad) {
    cantidadDeComida -= unaCantidad
  }

  method cargarBebidas(unaCantidad) {
    cantidadDeBebidas += unaCantidad
  }

  method descargarBebidas(unaCantidad) {
    cantidadDeBebidas -= unaCantidad
  }

  override method prepararViaje() {
    super()
    self.cargarComida(4 * cantidadDePasajeros)
    self.cargarBebidas(6 * cantidadDePasajeros)
    self.acercarseUnPocoAlSol()
  }

  override method escapar() {
    self.acelerar(velocidad)
  }

  override method avisar() {
    self.descargarComida(1 * cantidadDePasajeros)
    self.descargarBebidas(2 * cantidadDePasajeros)
  }

  override method estaDeRelajo() {
    return super() and cantidadDeComida < 50
  }
}

class NavesDeCombate inherits Nave {
  var mensajes = []
  var estaInvisible = false
  var misilesDesplegados = false
  
  method mensajesEmitidos() = mensajes
  method estaInvisible() = estaInvisible
  method misilesDesplegados() = misilesDesplegados

  method ponerseVisible() {
    estaInvisible = false
  }

  method ponerseInvisible() {
    estaInvisible = true
  }

  method desplegarMisiles() {
    misilesDesplegados = true
  }

  method replegarMisiles() {
    misilesDesplegados = false
  }

  method emitirMensaje(mensaje) {
    mensajes.add(mensaje)
  }

  method primerMensajeEmitido() {
    return mensajes.first()
  }

  method ultimoMensajeEmitido() {
    return mensajes.last()
  }

  method esEscueta() {
    return mensajes.all({unMensaje => unMensaje.size() <= 30})
  }

  method emitioMensaje(mensaje) {
    return mensajes.contains(mensaje)
  }

  override method prepararViaje() {
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en mision")
  }

  override method estaTranquila() {
    return super() and not misilesDesplegados
  }

  override method escapar() {
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar() {
    self.emitirMensaje("Amenza recibida")
  }
}

//Dos variantes nuevas de nave

class NaveHospital inherits NaveDePasajeros {
  var quirofanosPreparados = false

  method quirofanosPreparados() = quirofanosPreparados

  method prepararQuirofanos() {
    quirofanosPreparados = true
  }

  method tranquilizarQuirofanos() {
    quirofanosPreparados = false
  }
  
  override method estaTranquila() {
    return super() and not quirofanosPreparados
  }

  override method recibirAmenaza() {
    super()
    self.prepararQuirofanos()
  }
}

class NaveDeCombateSigilosa inherits NavesDeCombate {
  override method estaTranquila() {
    return super() and not estaInvisible
  }

  override method escapar() {
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}