if [ -z "$1" ]
then
  echo You need to provide a username
  exit 1
fi
docker run -it --rm --link postgres:postgres postgres psql -h postgres -U $1 postgres
