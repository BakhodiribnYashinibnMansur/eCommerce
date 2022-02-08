package model

type CompEmployee struct {
	Id           int    `json:"-" db:"id"`
	EmployeeName string `json:"employeeName" binding:"required"`
	Password     string `json:"password" binding:"required"`
	Role         string `json:"role" binding:"required"`
}

type SignInInInput struct {
	EmployeeName string `json:"employeeName" binding:"required"`
	Password     string `json:"password" binding:"required"`
}
