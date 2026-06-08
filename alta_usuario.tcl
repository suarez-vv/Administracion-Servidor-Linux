#!/usr/bin/tclsh

proc validar_nombreUser {usuario} {

    #Validar que no este vacio
    if {$usuario eq ""} {
        puts "\n\t   Error: Debe ingresar un nombre de usuario."
        puts "\n\t   Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }

    #Validar contenido
    if {![regexp {^[a-zA-Z0-9_-]+$} $usuario]} {
        puts "\n\t   El contenido del nombre de usuario no es valido."
        puts "\n\t   Solo se permiten letras,  numeros, '-' y '_'"
        puts "\n\t   Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

proc verificar_existencia {usuario} {
    if {![catch {exec id $usuario}]} {
        puts "\n\t   Error: El usuario ya existe."
        puts "\n\t   Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

proc validar_contrasena {password} {
    if {[string length $password] < 4} {
        puts "\n\t   Error: La contraseña debe tener al menos 4 caracteres."
        puts "\n\t   Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

proc crear_usuario {usuario} {
    if {[catch {exec sudo useradd -m $usuario} resultado]} {
        puts "\n\t   Error al crear usuario:"
        puts $resultado

        puts "\n\t   Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

proc asignar_contrasena {usuario password} {
    if {[catch {exec sudo sh -c "echo '$usuario:$password' | chpasswd"} resultado]} {
        puts "\n\t   Error al asignar contraseña:"
        puts $resultado

        puts "\n\t   Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

exec clear >@stdout
puts "\n\t================================"
puts "\t        ALTA DE USUARIO"
puts "\t================================"

#Pedir el nombre del usuario
puts -nonewline "\t   Nombre de usuario: "
flush stdout
gets stdin usuario

# Validar contenido de nombre de usuario
if {![validar_nombreUser $usuario]} {
    return
}

# Verificar si ya existe
if {![verificar_existencia $usuario]} {
    return
}

#Pedir la contraseña del usuario
puts -nonewline "\t   Contraseña: "
flush stdout
gets stdin password

# Validar contraseña
if {![validar_contrasena $password]} {
    return
}


# Crear usuario
if {![crear_usuario $usuario]} {
    return
}

# Asignar contraseña
if {![asignar_contrasena $usuario $password]} {
    return
}

puts "\n\t   Usuario creado correctamente."

puts "\n\t   Presione ENTER para regresar al menú..."
gets stdin pausa