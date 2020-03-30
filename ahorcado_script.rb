#Juego de ahorcado (Adivinar palabra)
require 'tty-font'
require 'rainbow'

#Encabezado principal
def titulo mensaje
    texto = TTY::Font.new(:doom)
    titulo = texto.write("Ahorcado")
    puts Rainbow(titulo).color("#FF2075").bright
    puts "\n#{mensaje}\n\n"
end

#Inicializa las variables principales
def inicializar
    categoria = gets.to_i
    case categoria
    when 1
        load 'nombres_script.rb'
    when 2
        load 'apellidos_script.rb'
    else
        load 'verbos_script.rb'
    end

    @respuesta = []
    @intentos = 0
    #Inicializar @limite según longitud de la palabra
    case @palabra.length
    when 0..4
        @limite = 7
    when 5..8
        @limite = 12
    when 9..15
        @limite = 20
    else
        @limite = 30
    end
    #Inicializar respuesta con guines bajos
    @palabra.length.times do |x|
        @respuesta[x] = "_"
    end
    return @respuesta
end

#El usuario introduce letras
def responder
    while @respuesta.join != @palabra
        system("clear")
        titulo "Adivina la palabra"
        puts Rainbow(@respuesta.join(" ")).green
        puts "\nIntentos: " + Rainbow(@intentos).red.blink
        print "\nEscribe una letra: "
        letra = gets.chomp
        #Incrementar @intentos si la letra no está
        unless @palabra.include?(letra)
            @intentos += 1
        end
        #Interrumpir el ciclo si alcanza el limite de intentos
        break if @intentos >= @limite
        #Ciclo que busca y reemplaza letras
        @respuesta.length.times do |x|
            if @palabra[x] == letra
                @respuesta[x] = letra
            end
        end
    end
    system("clear")
    if @intentos >= @limite
        titulo Rainbow("Perdiste! Intentalo de nuevo").red.blink + "\nRespuesta: #{@palabra}"
    else
        titulo Rainbow("Felicidades, has ganado!").green.blink
    end
end

#Ejecución del programa
system("clear")
titulo "Elije una categoría\n1-Nombres\n2-Apellidos\n3-Verbos"
inicializar
responder
