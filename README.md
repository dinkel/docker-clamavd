Usage
-----

    docker run -d -p 3310:3310 dinkel/clamavd
    
or:

    docker run -d --name clamavd dinkel/clamavd
    docker run -d --link clamavd:clamavd application-with-clamdscan-or-something
