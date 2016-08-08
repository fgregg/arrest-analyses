MAKEFLAGS += --warn-undefined-variables
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

PG_HOST=localhost
PG_USER=datamade
PG_DB=arrests
PG_PORT=9000

