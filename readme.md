# Usage
1. Select `Create Instace` from Lightsail console
1. Under `Select a blueprint` click `OS Only` and the choose `Ubuntu`
1. Paste the following code snippet in the `Add launch script` box
```
curl -o lightsail-docker.sh https://raw.githubusercontent.com/dbertolotto/lightsail-docker/master/lightsail-docker.sh
chmod +x ./lightsail-docker.sh
./lightsail-docker.sh
```
By default the machine loads the file `/docker/docker-compose.yml` upon start.

# Credits
Taken and modified from https://github.com/mikegcoleman/todo
