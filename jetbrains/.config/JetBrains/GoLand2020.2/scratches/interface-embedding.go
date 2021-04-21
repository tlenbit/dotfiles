package main

import "fmt"

type Reader interface {
	Read() string
	Close()
}

type Writer interface {
	Write() string
}

type ReaderWriter interface {
	Reader
	Writer
	Close()
}

type RWType struct {
	name string
}

func (rw *RWType) Read() string {
	return "read: " + rw.name
}

func (rw *RWType) Write() string {
	return "write: " + rw.name
}

func (rw *RWType) Close() {
	fmt.Println("CLOSING")
}

func process(rw ReaderWriter) string {
	rw.Close()
	return fmt.Sprintf("%v, %v", rw.Read(), rw.Write())
}

func main() {
	rw := RWType{"one"}

	x := process(&rw)
	fmt.Println(x)
}
