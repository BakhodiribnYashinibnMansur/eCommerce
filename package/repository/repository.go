package repository

import (
	"ecommercego/model"

	"github.com/jmoiron/sqlx"
)

type Authorization interface {
	CreateCompanyEmployee(admin model.CompEmployee) (int, error)
	GetCompEmployee(username, password string) (model.CompEmployee, error)
}

type Repository struct {
	Authorization
}

func NewRepository(db *sqlx.DB) *Repository {
	return &Repository{
		Authorization: NewAuthPostgres(db),
	}
}
