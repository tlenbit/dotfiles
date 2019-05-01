## docker

- sudo docker run --name pginstance -p 5432:5432 -e POSTGRES_PASSWORD=123456 -d postgres
- sudo docker run --name mongoinstance -p 27017:27017 --rm -v /home/jc/Documents/deps/mongodata:/data/db mongo

## nvidia drivers for linux

### switch between graphic renderer
- prime-select query
- sudo prime-select nvidia
- sudo prime-select intel

## wifi connection

- nmcli device wifi list
- nmcli device wifi connect "iPhone ABC" password "xxx"

## convert image

- convert cover.jpg -resize 700 out.jpg

## wget directory

- wget -r -np -nH --cut-dirs=3 -R index.html http://music.pronskiy.ru/Christ./Ch