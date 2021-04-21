package main

import (
	"bufio"
	"fmt"
	"os"
)

type StatsConn struct {
}

func main() {
	input := bufio.NewReader(os.Stdin)

	for {
		fmt.Print("> ")
		line, _, _ := input.ReadLine()
		if string(line) == "exit" {
			break
		}


		fmt.Println("->", string(line))
	}
}
