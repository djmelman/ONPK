# Dokumentácia ONPK
Autor: Bc. Tomáš Ťaptík

## Zadanie 1: Terraform

V zložke Terraform sa nachádzajú súbory pre prácu s OpenStackom podľa zadania.

## Zadanie 2: DockerFiles

### Príprava
Inštalácia Docker a následný pull zadaných repozitárov v zadaní.

### Riešenie

#### Backend

Do DockerFile boli pridané nasledujúce príkazy.
```
COPY --from=builder /build/main /app/  
```
```
WORKDIR /app    
```
```                       
CMD ["./main"]
```
#### Frontend

Do DockerFile boli pridané nasledujúce príkazy.
```
EXPOSE 8080
```
```
CMD [ "nginx", "-g", "daemon off;" ]
```

### Build a Push

Prihlásime sa do docker hubu:
 ```
 docker login
 ```
V zložkách pre backend aj frontend najprv buildneme image príkazom docker:
 ```
 build -t <názov>:<tag> .
 ```
Následne otagujeme image:
 ```
 docker tag <názov>:<tag> tomastaptik/<názov>:<tag>
 ```
Pushneme ho do repozitára:
 ```
 docker push tomastaptik/<názov>:<tag>
 ```
## Zadanie 3: Helm

## Zadanie 4: CI/CD

Súbory pre CI/CD zadanie sú v zložke cicd.