# Airbnb Database API

## Overview

A Postgres database accessed using Golang. GUI constructed using Javascript and HTML.

Back-end files: 
* `import.sql` contains the create table scripts
* `listofqueries.sql` contains the queries used. Also in `queries.go`
* `queries.go` and `db.go` connects to the database.

Front-end files:
* `index.js`
* `index.html`

## Getting Started

 1. To run on a development machine, run: `go run *.go`.
 2. Open new a terminal and enter `browser-sync start --server --no-online --files="**/*"` to start the frontend
 3. A webpage should pop up.

### PostgreSQL

#### Installation

- run [`sudo apt install postgresql-common` then
`sudo sh /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh`](https://wiki.postgresql.org/wiki/Apt#Quickstart)

