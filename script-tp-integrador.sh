# ---------- FUNCIONES ---------- #
mostrar_menu(){
    clear
    echo "1) Fibonacci."
    echo "2) Invertir entero."
    echo "3) Evaluar palindromo."
    echo "4) Lineas en archivo de texto."
    echo "5) Ordenar 5 numeros."
    echo "6) Mostrar tipos de archivos diferentes en directorio."
    echo "7) Salir"
    echo "-------------------------------------------------------------"
}

salir_saludando(){
    NOMBRE=$1 # Guardo el parametro nro. 1 que recibe la function
    echo "Chau $NOMBRE"
    sleep 2
}

fibonacci(){
	n=$1
	a=1
	b=1
	c=2
	d=0
	echo "$a"
	echo "$b"
	while((c<n)) 
	do
		d=$((a+b))
		echo "$d"
		a=$b
		b=$d
		c=$((c+1))
	done
}

revertir(){
	n=$1
	echo "Numero invertido:"
	echo $n | rev
}

palindromo(){
	str=$1
	len=`echo $str | wc -c`
	len=`expr $len - 1`
	i=1
	j=`expr $len / 2`
	#Recorro la mitad del string
	while test $i -le $j
	do
		#Asigno letra de la primera mitad
		k=`echo $str | cut -c $i`
		#Asigno letra de la segunda mitad
		l=`echo $str | cut -c $len`
		#Si son diferentes, no es palindromo
		if test $k != $l 
		then
			echo "No es palindromo"
			return
		fi
		#Continuo avanzando por el string
		i=`expr $i + 1`
		len=`expr $len - 1`
	done
	#Si llegamos al final del string sin encontrar diferencias, es palindromo.
	echo "Es un palindromo"
}

contar_lineas(){
	arch=$1
	if [ -f "$arch" ]; then
		wc -l < "$arch"
	else
		echo "ERROR: El archivo no existe"
	fi
}

ordenar(){
	IFS=' ' read -ra arr -p "Ingrese los 5 numeros a ordenar, separados por espacio: "
	if [ ${#arr[@]} -eq 5 ]; then
		sort -n <(printf "%s\n" "${arr[@]}")
	else
		echo "ERROR: No ingreso 5 numeros."
	fi
}

mostrar_contenido(){
	dir=$1
        if [ -d "$dir" ]; then
		find $dir -type f | sed 's/.*\.//' | sort | uniq -c
        else
	        echo "ERROR: El directorio no existe"
        fi
}
# ---------------------------- PROGRAMA PRINCIPAL ---------------------------- #
OPCION=0
mostrar_menu
while true; do
    read -p "Ingrese una opcion: " OPCION # Mensaje y read en la misma linea
    case $OPCION in
	1) echo "Ingrese el numero para calcular Fibonacci"
	read NUMBER
	fibonacci NUMBER;;
	2) echo "Ingrese el numero para invertir"
	read NUMERO
	revertir $NUMERO;;
	3) echo "Ingrese el texto para verificar palindromo"
	read PALIN
	palindromo $PALIN;;
	4) echo "Ingrese el archivo a contabilizar"
	read ARCHIVO
	contar_lineas $ARCHIVO;;
	5) ordenar;;
	6) echo "Ingrese el directorio a contabilizar"
	read DIRECTORIO
	mostrar_contenido $DIRECTORIO;;
	7) salir_saludando `whoami`
	break;;
	*)  echo "Opcion incorrecta";;
    esac
done
exit 0
