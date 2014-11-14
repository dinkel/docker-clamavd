docker-clamavd
==============

ClamAV daemon as a Docker image. It *builds* with a current virus database and
*runs* `freshclam` in the background constantly updating the database. `clamd` 
is listening on exposed port `3310`.

Usage
-----

    docker run -d -p 3310:3310 dinkel/clamavd
    
or linked (this is how I use it)

    docker run -d --name clamavd dinkel/clamavd
    docker run -d --link clamavd:clamavd application-with-clamdscan-or-something
    
Configuration (environment variables)
-------------------------------------

None at the moment.

Data persistence
----------------

It has been a design decision to discard exporting the virus database to a data 
volume as it will be always be brought up-to-date (quite quickly) upon starting 
a new container.

Explaining run.sh
-----------------

This is a poor man's `supervisord`. It is my strong (but not so much challenged)
belief, that there shouldn't be yet another process manager (Docker has one, 
CoreOS has one (with `fleet` and `systemd`).

The only thing this script does is watching its forked (background) processes
and as soon as one dies, it terminates all the others and exits with the code 
of the first dying process.

Todo
----

* Make sure my little script above works in all circumstances. I know that when
  omitting the `-d` one cannot stop the process using `<Ctrl><c>`.
  
* Make sure all logs are written to `stdout` or `stderr`.
