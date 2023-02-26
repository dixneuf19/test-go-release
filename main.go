package main

import "fmt"

var (
	Version        = "dev"
	CommitHash     = "n/a"
	BuildTimestamp = "n/a"
)

func main() {
	fmt.Printf("%s-%s (%s)", Version, CommitHash, BuildTimestamp)
}
