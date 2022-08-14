# Requirements

- [docker](https://docs.docker.com/engine/install/)

- [docker-compose](https://docs.docker.com/compose/install/)

# KL FHIR starter project

* Clone this project
* Step into the cloned folder

```shell

cd dk-kl-fhir-starter

```

* Run the following: 
```shell
docker-compose up -d
```
* Done!


# Configuration

1) Hapi configuration, database, startup implementation guides: configs/kl.yaml

2) Test template: templates/*.html, img/*

3) Deployment: docker-compose.yaml

- ig service: Serving implementation guide (package.tgz output after building implementation guides)
   - ig/hiv-vn/package.tgz: case-reporting-hiv-vn implementation guide
   - ig/snomed/package.tgz: snomed-ct-custom

- web service: hapi service
    - Proxy tomcat port (8080) to port 3003 (on deployed server)
    
- db service: mysql 8
