postgres:
	docker run --name pg-db -e POSTGRES_USER=user -e POSTGRES_PASSWORD=password -e POSTGRES_DB=mydb -p 5432:5432 -d postgres

createdb:
	 docker exec -it pg-db createdb --username=user --owner=user simple_bank

dropdb:
	  docker exec -it pg-db dropdb --username=user simple_bank

migrateup:
	migrate -path db/migrations -database "postgresql://user:password@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migrations -database "postgresql://user:password@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc