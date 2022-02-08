package service

import (
	"ecommercego/model"
	"ecommercego/package/repository"
)

type Authorization interface {
	CreateCompanyEmployee(admin model.CompEmployee) (int, error)
	GenerateToken(username, password string) (string, error)
	ParseToken(token string) (int, error)
}

type Service struct {
	Authorization
}

func NewService(repo *repository.Repository) *Service {
	return &Service{Authorization: NewAuthService(repo.Authorization)}
}
