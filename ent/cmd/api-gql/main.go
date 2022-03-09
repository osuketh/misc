package main

import (
	"context"
	"ent-test/ent"
	"ent-test/ent/migrate"
	"ent-test/graph"
	"log"
	"net/http"

	"entgo.io/contrib/entgql"
	"entgo.io/ent/dialect"
	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/handler/debug"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/alecthomas/kong"

	// _ "github.com/mattn/go-sqlite3"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	var cli struct {
		Addr  string `name:"address" default:":8081" help:"Address to listen on."`
		Debug bool   `name:"debug" help:"Enable debugging mode."`
	}
	kong.Parse(&cli)
	client, err := ent.Open(dialect.MySQL, "root:password@tcp(localhost:3306)/misc")
	if err != nil {
		log.Fatal("failed to open the database:", err)
	}
	if err := client.Schema.Create(context.Background(), migrate.WithGlobalUniqueID(true)); err != nil {
		log.Fatal("failed to create schema:", err)
	}
	srv := handler.NewDefaultServer(graph.NewSchema(client))
	srv.Use(entgql.Transactioner{TxOpener: client})
	if cli.Debug {
		srv.Use(&debug.Tracer{})
	}
	http.Handle("/", playground.Handler("GraphQL playground", "/query"))
	http.Handle("/query", srv)
	log.Println("listening on", cli.Addr)
	if err := http.ListenAndServe(cli.Addr, nil); err != nil {
		log.Fatal(err)
	}
}
