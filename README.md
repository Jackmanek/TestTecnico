## Prueba Técnica ##

- Descomprimir el .rar
- Con Docker Desktop instalado o en Unix
- Abrir carpeta en una terminal
- Ejecutar el comando 
	- docker-compose up --build -d
- He añadido el comando para los test, se que no se hace en producción, pero si tenéis Docker Desktop y entráis al contenedor en los Logs, aparecen los test, si no aparecen los test, hay que ejecutar el comando; 
	- docker-compose down --volumes
	y despues volver a levantarlo
	- docker-compose up --build -d

- El repositorio lo he hecho publico por si queréis descargarlo
	- https://github.com/Jackmanek/incidenciasApp.git 

# Si se prueba el repositorio en Desarrollo, hay que realizar los siguientes comando;
	- composer update o composer install
	- php artisan key:generate
	- composer require livewire/livewire (solo si al hacer update no se instalan las dependencias)
	- php artisan migrate
	# Para hacer los test
		-php artisan test
	# Para comprobar he creado varios Usuarios cono roles distintos
	- php artisan db:seed
	
# Los métodos en desarrollo funciona perfectamente, he realizado la relación y las utilizo a la hora de asignar un usuario soporte a un incidencia, se puede comprobar en los modelos

# En el método store, a la hora de crear también hay una relación, esta da un fallo de no definido, pero existe realmente y realiza el sabe() como se espera.

# Probar Roles
- Administrador
    - admin@example.com
    - password
- Soporte
    - jose@example.com
    - password

# TEST Hay dos métodos que no pasan el test
	- ambos son a la hora de redireccionar;
	- El primero es porque quería utilizar el modal y este me obliga a no utilizar un redirect(). 
	- Y el segundo es en el momento de acceder a la APi autorizada, el fallo debería ser un 401, pero me lanza un 301 por lo mismo hace un redirect y no gestiona el error correctamente.
