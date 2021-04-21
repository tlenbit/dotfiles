package main

import "fmt"

type Animal struct {
	name string
}

type Speaker interface {
	Speak()
}

func (a Animal) Speak() {
	fmt.Println("ANIMAL SPEAKS", a.name)
}

type Dog struct {
	Animal
	barks int
}

func (d Dog) Speak() {
	fmt.Println("DOG BARK")
}

type Cat struct {
	Animal
	meow int
}

func (c Cat) Speak() {
	fmt.Println("CAT MEOUWS")
}

func main() {
	animals := []Speaker{
		Dog{
			Animal: Animal{name: "DOGO"},
			barks:  0,
		},
		Cat{
			Animal: Animal{name: "CATO"},
			meow:   0,
		},
	}

	for _, animal := range animals {
		animal.Speak()
	}

	fmt.Println("------")

	var animalillo Speaker
	typeAnimal := "dog"

	switch typeAnimal {
	case "cat":
		animalillo = Cat{
			Animal: Animal{"kitty"},
			meow:   20,
		}
	case "dog":
		animalillo = Dog{
			Animal: Animal{"doge"},
			barks:  10,
		}
	}

	animalillo.Speak()
}
