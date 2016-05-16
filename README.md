docker run -d -p 3310:3310 clamav

docker run -d --name clamav clamav

docker run -d --link clamav:clamav application-with-clamdscan
