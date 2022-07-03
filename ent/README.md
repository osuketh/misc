# misc-ent

Migration files using ent's versioned migration is formatted for https://github.com/golang-migrate/migrate as default.

```bash
# gen graphql schema
gqlgen

# versioned migration (may not use)
go run ./cmd/migration

migrate -database 'mysql://root:password@tcp(localhost:3306)/misc' -path migrations up

# gen schema (https://github.com/ariga/entimport)
# go run ariga.io/entimport/cmd/entimport -dsn "mysql://root:password@tcp(localhost:3306)/misc"

# gen ent schema
go generate ./ent/...

# run server
go run ./cmd/api-gql
```
