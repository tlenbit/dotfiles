package main

import "fmt"

type Base struct {
	b string
	tag int
}

func (b *Base) Describe() string {
	return fmt.Sprintf("%v", b.b)
}

func (b *Base) DescribeTag() string {
	return fmt.Sprintf("base's tag: %v", b.tag)
}

type Container struct {
	Base
	a string
	tag int
}

func (c *Container) Describe() string {
	return c.Base.Describe() + c.a
}

func (c *Container) DescribeTag() string {
	return fmt.Sprintf("container's tag: %v", c.tag)
}

func main() {
	c1 := Container{}
	c1.a = "Hello"
	c1.Base.b = "World!"

	fmt.Println(c1.a, c1.b)

	c2 := Container{
		Base: Base{b: "Hallo"},
		a:    "World",
	}

	fmt.Println(c2.a, c2.b)

	b1 := Base{
		b:   "b1",
		tag: 1,
	}
	c3 := Container{
		Base: b1,
		a:    "a3",
		tag:  2,
	}
	fmt.Println(b1.DescribeTag())
	fmt.Println(c3.DescribeTag())
}
