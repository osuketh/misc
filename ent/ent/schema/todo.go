// Code generated by entimport, DO NOT EDIT.

package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

// Todo holds the schema definition for the Todo entity.
type Todo struct {
	ent.Schema
}

// Fields of the Todo.
func (Todo) Fields() []ent.Field {
	return []ent.Field{field.Int("id"), field.String("text"), field.Time("created_at").Optional(), field.Enum("status").Values("IN_PROGRESS", "COMPLETED"), field.Int("priority"), field.Int("todo_parent").Optional()}

}

// Edges of the Todo.
func (Todo) Edges() []ent.Edge {
	return []ent.Edge{edge.To("child_todos", Todo.Type), edge.From("parent_todo", Todo.Type).Ref("child_todos").Unique().Field("todo_parent")}

}
