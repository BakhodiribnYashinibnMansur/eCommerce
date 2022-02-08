package repository

import (
	"ecommercego/model"
	"ecommercego/package/utility"
	"fmt"

	"github.com/jmoiron/sqlx"
)

type AuthPostgres struct {
	db *sqlx.DB
}

func NewAuthPostgres(db *sqlx.DB) *AuthPostgres {
	return &AuthPostgres{db: db}
}

func (r *AuthPostgres) CreateCompanyEmployee(admin model.CompEmployee) (int, error) {
	var id int
	currentTime := utility.GetCurrentTime()
	query := fmt.Sprintf("INSERT INTO %s (created_at, username ,  password_hash ) values ($1,$2,$3) RETURNING id", CompanyEmployeeTable)
	row := r.db.QueryRow(query, currentTime, admin.EmployeeName, admin.Password)
	if err := row.Scan(&id); err != nil {
		return 0, err
	}
	return id, nil
}

func (r *AuthPostgres) GetCompEmployee(username, password string) (model.CompEmployee, error) {
	var user model.CompEmployee

	query := fmt.Sprintf(" SELECT 	 id FROM %s WHERE username=$1 AND password_hash=$2", CompanyEmployeeTable)
	err := r.db.Get(&user, query, username, password)
	return user, err
}
