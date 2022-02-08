package handler

import (
	"ecommercego/package/service"

	"github.com/gin-gonic/gin"
)

type Handler struct {
	services *service.Service
}

func NewHandler(services *service.Service) *Handler {
	return &Handler{services: services}
}

func (h *Handler) InitRoutes() *gin.Engine {
	router := gin.New()
	auth := router.Group("/auth")
	{
		admin := auth.Group("/compemployee")
		{
			admin.POST("/sign-up", h.SignUpCompUser)
			admin.POST("/sign-in", h.SignInCompUser)
		}
		costumer := auth.Group("/costumer")
		{
			costumer.POST("/sign-up", h.SignUpCostumer)
			costumer.POST("/sign-in", h.SignInCompUser)
		}
	}

	companyService := router.Group("/comser", h.UserIdentity)
	{
		companyService.GET("/comser")
	}

	return router
}
