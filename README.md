<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="200" alt="Nest Logo" /></a>
</p>


# Teslo API

1. Clonar proyecto
2. ```yarn install```
3. Clonar el archivo ```.env.template``` y renombrarlo a ```.env```
4. Cambiar las variables de entorno
5. Levantar la base de datos
```
docker compose up -d
```

6. Levantar: ```yarn start:dev```

7. Ejecutar SEED 
```
http://localhost:3000/api/seed
```



# Production notes:

Ejecutar este comando
```
docker compose -f docker-compose.prod.yml build
```


## Docker Repo Name
[klerith/teslo-shop-cors:latest](https://hub.docker.com/repository/docker/klerith/teslo-shop-cors/general)

docker buildx build --platform linux/amd64,linux/arm64 -t klerith/teslo-shop-cors:1.0.0 --push .


# Mis notas 


## Sección 6 Multi-Stage Build

Recuerda que para subir debes estar logueado desde docker desktop en tu equipo y tener claro tu nombre de usuario.
Id de usuario de Docker HUB
juliocesarforero

### Vañlidar que estas logueado 

Desde la terminal ejecutar 

```
docker login
```

Se espera que obtengas como respuesta:

```
PS C:\CursosUdemy\DockerGuiaPractica\docker-teslo-shop> docker login
Authenticating with existing credentials... [Username: juliocesarforero]

i Info → To login with a different account, run 'docker logout' followed by 'docker login'


Login Succeeded
PS C:\CursosUdemy\DockerGuiaPractica\docker-teslo-shop>
```

Debes asegurarte que tu imagen tenga el formato adecuado para Docker Hub:

```
docker tag <nombre_imagen_local>:<tag> <tu_usuario_dockerhub>/<nombre_repositorio>:<tag>
```

al listar las imagenes de docker con el comando:

```
docker image ls
```

obtenemos una respeusta como:

```
PS C:\CursosUdemy\DockerGuiaPractica\docker-teslo-shop> docker image ls
REPOSITORY                            TAG            IMAGE ID       CREATED          SIZE
juliocesarforero/teslo-shop-backend   1.0.1          74c6bf553e1e   9 minutes ago    419MB
juliocesarforero/teslo-shop-backend   2.0.0          5581034a95e3   9 minutes ago    419MB
docker-teslo-shop-app                 latest         0e25f90bd932   26 minutes ago   1.14GB
<none>                                <none>         21538d3a094f   43 hours ago     239MB
cron-ticker                           test           8911fa2b1d04   43 hours ago     239MB
```

en este punto ya podriamos ejecutar entonces la instruccion:

```
docker tag juliocesarforero/teslo-shop-backend:2.0.0 juliocesarforero/teslo-shop-backend:2.0.0
```

Para subirla a docker hub debemos ejecutar el siguiente comando :

```
docker push <tu_usuario_dockerhub>/<nombre_repositorio>:<tag>
```

Siguiendo el formato debe quedar:

```
docker push juliocesarforero/teslo-shop-backend:2.0.0`
```

como respuesta se espera:

```
PS C:\CursosUdemy\DockerGuiaPractica\docker-teslo-shop> docker push juliocesarforero/teslo-shop-backend:2.0.0
The push refers to repository [docker.io/juliocesarforero/teslo-shop-backend]
0628b2d9d165: Pushed
5432aa916e08: Pushed
cd8e2dcb023a: Pushed
878e1d9430e5: Pushed
fe07684b16b8: Pushed
2506673f5536: Pushed
98c4889b578e: Pushed
2f347a3b5f07: Pushed
2.0.0: digest: sha256:5581034a95e34605c6c3b492705b1ca5815a01aaa9f018846ddb51f633c918c7 size: 856
PS C:\CursosUdemy\DockerGuiaPractica\docker-teslo-shop>
```

al validarlo en docker hub tenemos:

![DockerHub](https://github.com/JulioCesarForero/docker-teslo-shop/blob/final-seccion-6/ImagenesEvidencias/imageDockerHub.png)


## Sección 7 Deployments y Registros

82. Para la contruccion de imagenes con multiples arquitecturas el comando a usar es :

```
docker buildx build --platform linux/amd64,linux/arm64 -t juliocesarforero/teslo-shop-backend:2.0.0 --push .
```

![Multiples Arquitecturas](ImagenesEvidencias\imageMultiplesArquitecturas.png)

Dependiendo de diferentes factores en algunas ocaciones se recomienda hacerlo de manera separada 

### Para AMD64
docker buildx build --platform linux/amd64 -t juliocesarforero/teslo-shop-backend:2.0.0-amd64 --push .

### Para ARM64  
docker buildx build --platform linux/arm64 -t juliocesarforero/teslo-shop-backend:2.0.0-arm64 --push .

### Crear manifest multi-plataforma
docker buildx imagetools create -t juliocesarforero/teslo-shop-backend:2.0.0 \
  juliocesarforero/teslo-shop-backend:2.0.0-amd64 \
  juliocesarforero/teslo-shop-backend:2.0.0-arm64

---

85. 4:16min 

se desarrolla el lab en el proyecto C:\CursosUdemy\DockerGuiaPractica\teslo-testing\docker-compose.yml


86. Digital Ocean - Aprovicionamiento de Base de Datos
87. Probar base de datos
90. Desplegar la imagen directamente desde DockerHub

--- 
En digital ocean es necesario agregar TC y configurar la conexion del aprovisionamiento de la DB 
