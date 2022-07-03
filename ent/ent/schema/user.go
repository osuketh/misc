package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/dialect/entsql"
	"entgo.io/ent/schema"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
)

type User struct {
	ent.Schema
}

func (User) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").MaxLen(36).Comment("ID"),
		field.String("name").Comment("名前"),
		field.String("email").Unique(),
		field.Enum("role").Comment("権限").Values("admin", "user"),
		field.Time("deleted_at").Optional(),
		field.Time("created_at").Annotations(entsql.Annotation{
			Default: "CURRENT_TIMESTAMP",
		}).Immutable(),
		field.Time("updated_at").Annotations(entsql.Annotation{
			Default: "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP",
		}).Immutable(),
	}
}

func (User) Indexes() []ent.Index {
	return []ent.Index{
		index.Fields("name"),
	}
}

func (User) Edges() []ent.Edge {
	return []ent.Edge{edge.To("groups", Group.Type)}
}
func (User) Annotations() []schema.Annotation {
	return []schema.Annotation{
		entsql.Annotation{Options: "ENGINE = INNODB"},
	}
}
