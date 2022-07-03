# misc-ent

```bash
# 1. gen graphql schema
gqlgen

# versioned migration (may not use)
go run ./cmd/migration

# 2. migration
dbmate up

# 3. gen schema (https://github.com/ariga/entimport)
go run ariga.io/entimport/cmd/entimport -dsn "mysql://root:password@tcp(localhost:3306)/misc"

# 4. gen ent schema
go generate ./ent/...

# 5. run server
go run ./cmd/api-gql
```

Migration files using ent's versioned migration is formatted for https://github.com/golang-migrate/migrate as default.


```
migrate -database 'mysql://root:password@tcp(localhost:3306)/misc' -path migrations up
```
