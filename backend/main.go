package main

import (
	"backend/routes"
	"log"
)

func main() {
	router := routes.SetupRouter()
	log.Println("Server running on port 3000")
	if err := router.Run(":3000"); err != nil {
		log.Fatal(err)
	}
}