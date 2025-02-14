package routes

import (
	"backend/controllers"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	router := gin.Default()

	api := router.Group("/api")
	{
		api.GET("/kajis", controllers.GetKajis)
		api.POST("/kajis", controllers.CreateKaji)

		api.GET("/users", controllers.GetUsers)
		api.POST("/users", controllers.CreateOrUpdateUser)

		api.GET("/kaji_records", controllers.GetKajiRecords)
		api.POST("/kaji_records", controllers.CreateKajiRecord)
	}

	return router
}
