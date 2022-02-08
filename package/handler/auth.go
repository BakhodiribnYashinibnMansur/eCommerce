package handler

import (
	"ecommercego/model"
	"net/http"

	"github.com/gin-gonic/gin"
)

func (handler *Handler) SignUpCompUser(ctx *gin.Context) {
	var input model.CompEmployee
	if err := ctx.BindJSON(&input); err != nil {
		NewErrorResponse(ctx, http.StatusBadRequest, err.Error())
		return
	}
	id, err := handler.services.Authorization.CreateCompanyEmployee(input)
	if err != nil {
		NewErrorResponse(ctx, http.StatusInternalServerError, err.Error())
		return
	}
	ctx.JSON(http.StatusOK, map[string]interface{}{
		"id": id,
	})
}

func (handler *Handler) SignInCompUser(ctx *gin.Context) {
	var input model.SignInInInput
	if err := ctx.BindJSON(&input); err != nil {
		NewErrorResponse(ctx, http.StatusBadRequest, err.Error())
		return
	}
	token, err := handler.services.Authorization.GenerateToken(input.EmployeeName, input.Password)
	if err != nil {
		NewErrorResponse(ctx, http.StatusInternalServerError, err.Error())
		return
	}
	ctx.JSON(http.StatusOK, map[string]interface{}{
		"token": token,
	})
}

func (handler *Handler) SignUpCostumer(ctx *gin.Context) {

}

func (handler *Handler) SignInCostumer(ctx *gin.Context) {}
