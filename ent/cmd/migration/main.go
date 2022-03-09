package main

import (
	"context"
	"log"

	"ariga.io/atlas/sql/migrate"
	"entgo.io/ent/dialect"
	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/schema"
	"entgo.io/ent/entc"
	"entgo.io/ent/entc/gen"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	graph, err := entc.LoadGraph("./ent/schema", &gen.Config{})
	if err != nil {
		log.Fatalln(err)
	}
	tbls, err := graph.Tables()
	if err != nil {
		log.Fatalln(err)
	}

	d, err := migrate.NewLocalDir("./migrations")
	if err != nil {
		log.Fatalln(err)
	}

	dict, err := sql.Open(dialect.MySQL, "root:password@tcp(localhost:3306)/misc")
	if err != nil {
		log.Fatalln(err)
	}

	m, err := schema.NewMigrate(dict, schema.WithDir(d))
	if err != nil {
		log.Fatalln(err)
	}
	if err := m.Diff(context.Background(), tbls...); err != nil {
		log.Fatalln(err)
	}
}
