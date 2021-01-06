#!/bin/bash
if [[ $1 -lt 1 || $1 -gt 4 ]]; then #Comprueba si la opción está entre 1 y 4
	echo "La opción introducida no existe" #si no existe la opción te da este mensaje
else
	if [ $1 -eq 1 ]; then #opción 1
		read -p "Introduce el nombre del usuario: " nombre
		contadorLogs=0
		cont=0
		maxLineas=`cat usuarios.txt | wc -l`
		maxLineas$((maxLineas+1))
			while [ $cont -le $maxLineas ]; do
				linea=`cat usuarios.txt | head -$cont | tail -1` 
				user=`echo $linea | awk '{print $1}'`
				cont=$((cont+1))
				if [[ $nombre = $user ]]; then #Si el nombre es igual al del usuario suma 1 log
					contadorLogs=$((contadorLogs+1))
				fi
			done
			if [[ $contadorLogs -eq 0 ]]; then
				echo "El usuario no se ha logueado"
			else
				echo "El usuario $nombre se ha logueado $contadorLogs veces."
			fi
	fi #Fin opción 1
	if [[ $1 -eq 2 ]]; then #opción 2
		read -p "Introduce un mes: " inputMes
		contadorLogs=0
		cont=0
		contArray=0
		dias=()
		maxLineas=`cat usuarios.txt | wc -l`
			while [ $cont -le $maxLineas ]; do
				linea=`cat usuarios.txt | head -$cont | tail -1` 
				mes=`echo $linea | awk '{print $3}'`
				mes=${mes%?}
				cont=$((cont+1))
				if [[ $mes = $inputMes ]]; then
					contadorLogs=$((contadorLogs+1))
					dia=`echo $linea | awk '{print $2}'`
					dias[$contArray]=$dia
					contArray=$((contArray+1))
				fi
			done
			echo "En $inputMes se han logueado $contadorLogs veces en los dias ${dias[*]}"
	fi #Fin opción 2
	if [[$1 -eq 3 ]]; then #opción 3
		read -p "Introduce un dia: " inputDia
		read -p "Introduce un mes: " inputMes
		cont=0
		contArray=0
		nombres=()
		maxLineas=`cat usuarios.txt | wc -l`
		while [ $cont -le $maxLineas ]; do
			linea=`cat usuarios.txt | head -$cont | tail -1` 
			mes=`echo $linea | awk '{print $3}'`
			mes=${mes%?}
			cont=$((cont+1))
			if [[ $mes = $inputMes ]]; then
				dia=`echo $linea | awk '{print $2}'`
				if [[$inputDia -eq $dia]]; then
				nombre=`echo $linea | awk '{print $1}'`
				nombres[$contArray]=$nombre
				contArray=$((contArray+1))
				fi
			fi
		done
		echo "el $inputDia de $inputMes se conectaron ${nombres[*]}"
	fi #Fin opción 3
	if [[ $1 -eq 4 ]]; then #opción 4
		read -p "Introduce un nombre: " inputUsuario
		ultimoMes=-1
		ultimoDia=-1
		diaMax=0
		cont=0
		contArray=0
		meses=('enero' 'febrero' 'marzo' 'abril' 'mayo' 'junio' 'julio' 'agosto' 'septiembre' 'octubre' 'noviembre' 'diciembre')
		maxLineas=`cat usuarios.txt | wc -l`
		while [ $cont -le $maxLineas ]; do
			linea=`cat usuarios.txt | head -$cont | tail -1` 
			cont=$((cont+1))
			if [[ $inputUsuario = `awk '{print $1}'` ]]; then
				mes=`echo $linea | awk '{print $3}'`
				mes=${mes%?}
				for h in $(seq 0 11); do
					if [[ $mes = ${meses[$h]} ]]; then
						if [[ $ultimoMes -lt $h ]]; then
							ultimoMes=$h
							ultimoDia=`echo $linea | awk '{print $2}'`
						elif [[ $ultimoMes -eq $h ]]; then
							tempDia=`echo $linea | awk '{print $2}'`
							if [[ $ultimoDia -lt $tempDia ]]; then
								ultimoDia=$tempDia
							fi
						fi
					fi
				done
			fi
		done	
		if [[ $ultimoMes -eq -1 ]]; then
			echo "$inputUsuario nunca se ha logueado."
		else
			echo "$inputUsuario se logueó por ultima vez el $ultimoDia de ${meses[$ultimoMes]}."
		fi
	fi #Fin opción 4
fi #Fin opciones




















































read -p "Introduce un nombre: " inputUsuario
		ultimoDia=0
		diaMax=0
		cont=0
		contArray=0
		meses=('enero' 'febrero' 'marzo' 'abril' 'mayo' 'junio' 'julio' 'agosto' 'septiembre' 'octubre' 'noviembre' 'diciembre')
		maxLineas=`cat usuarios.txt | wc -l`
		while [ $cont -le $maxLineas ]; do
			linea=`cat usuarios.txt | head -$cont | tail -1` 
			mes=`echo $linea | awk '{print $3}'`
			mes=${mes%?}
			cont=$((cont+1))
			for j in `cat usuarios.txt | grep $inputUsuario`;do
				mes=`echo $linea | awk '{print $3}'`
				mes=${mes%?}
				dia=`echo $linea | awk '{print $2}'`
			done
		done	
		for h in $(seq 0 11); do
			if [[ $mes == ${meses[$h]} ]]; then
				pos=$h
			fi
		done
		if [[ $pos -gt $ultimoDia ]]; then
			ultimoDia=$pos
			diaDef=$dia
		fi
		if [[ `cat usuarios.txt | grep -w $inputUsuario | grep ${meses[$ultimoDia]} | wc -l` -eq 1 ]]; then
			echo "La ultima vez que se logueó fue $diaDef de ${meses[$ultimoDia]}"
		else
			for t in `cat usuarios.txt | grep -w $inputUsuario | grep ${meses[$ultimoDia]}`; do
				diact=`echo $t | awk '{print $2}'`
				if [[ $diaMax -lt $diact ]]; then
					diaMax=$diact
				fi
			done
		fi
		echo "La ultima vez que se logueó fue $diaMax de ${meses[$ultimoDia]}"