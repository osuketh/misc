package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type Group struct {
	ent.Schema
}

func (Group) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").Comment("ID"),
		field.String("user_id").Comment("ユーザーID"),
		field.String("name").Comment("名前"),
	}
}
func (Group) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("user", User.Type).
			Ref("groups").
			Unique().
			Field("user_id").
			Required(),
	}
}
func (Group) Annotations() []schema.Annotation {
	return nil
}
