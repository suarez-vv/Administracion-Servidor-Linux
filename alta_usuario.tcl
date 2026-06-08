#!/usr/bin/tclsh

exec clear >@stdout
puts "\n\t================================"
puts "\t        ALTA DE USUARIO"
puts "\t================================"

puts -nonewline "\t   Nombre de usuario: "
flush stdout
gets stdin usuario

# Validar que no esté vacío
if {$usuario eq ""} {
    puts "\n\t   Error: Debe ingresar un nombre de usuario."
    puts "\n\t   Presione ENTER para continuar..."
    gets stdin pausa
    return
}

# Verificar si ya existe
if {![catch {exec id $usuario}]} {
    puts "\n\t   Error: El usuario ya existe."
    puts "\n\t   Presione ENTER para continuar..."
    gets stdin pausa
    return
}

puts -nonewline "\t   Contraseña: "
flush stdout
gets stdin password

# Validar contraseña
if {[string length $password] < 4} {
    puts "\n\t   Error: La contraseña debe tener al menos 4 caracteres."
    puts "\n\t   Presione ENTER para continuar..."
    gets stdin pausa
    return
}

# Crear usuario
if {[catch {exec sudo useradd -m $usuario} resultado]} {
    puts "\n\t   Error al crear usuario:"
    puts $resultado

    puts "\n\t   Presione ENTER para continuar..."
    gets stdin pausa
    return
}

# Asignar contraseña
if {[catch {exec sh -c "echo '$usuario:$password' | sudo chpasswd"} resultado]} {
    puts "\n\t   Error al asignar contraseña:"
    puts $resultado

    puts "\n\t   Presione ENTER para continuar..."
    gets stdin pausa
    return
}

puts "\n\t  Usuario creado correctamente."

puts "\n\t   Presione ENTER para regresar al menú..."
gets stdin pausa