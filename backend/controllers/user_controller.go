package controllers

import (
	"net/http"
	"backend/models"

	"github.com/gin-gonic/gin"
)

func GetUsers(c *gin.Context) {
	var users []models.User
	if err := DB.Order("created_at desc").Find(&users).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, users)
}

func CreateOrUpdateUser(c *gin.Context) {
	var input models.User
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// uid をキーにユーザーを検索し、存在すれば更新、なければ新規作成
	var user models.User
	if err := DB.Where("uid = ?", input.UID).First(&user).Error; err != nil {
		// 新規作成
		user = models.User{
			UID:      input.UID,
			Name:     input.Name,
			Email:    input.Email,
			PhotoURL: input.PhotoURL,
		}
		if err := DB.Create(&user).Error; err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusCreated, user)
		return
	}
	// 既存ユーザーの更新
	user.Name = input.Name
	user.Email = input.Email
	user.PhotoURL = input.PhotoURL
	if err := DB.Save(&user).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, user)
}