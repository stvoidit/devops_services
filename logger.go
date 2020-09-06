package main

import (
	"bytes"
	"io"
	"net"
	"net/http"
	"os"
)

var (
	elastic = "http://" + os.Getenv("ELK")
)

func checkError(err error) {
	if err != nil {
		io.WriteString(os.Stderr, "error: "+err.Error())
	}
}

func main() {
	client := http.DefaultClient
	ServerAddr, err := net.ResolveUDPAddr("udp", ":10001")
	checkError(err)
	ServerConn, err := net.ListenUDP("udp", ServerAddr)
	checkError(err)
	defer ServerConn.Close()
	for {
		buf := make([]byte, 2048)
		n, _, err := ServerConn.ReadFromUDP(buf)
		checkError(err)
		cleanJSON := buf[bytes.Index(buf, []byte(`{`)):n]
		sentToELK(client, cleanJSON)
	}
}

func sentToELK(c *http.Client, msg []byte) {
	if elastic == "" {
		return
	}
	io.WriteString(os.Stdout, string(msg))
	req, err := http.NewRequest(http.MethodPost, elastic+"/nginx/logs", bytes.NewReader(msg))
	checkError(err)
	req.Header.Add("content-type", "application/json")
	resp, err := c.Do(req)
	if err != nil {
		checkError(err)
	} else {
		io.WriteString(os.Stdout, resp.Status)
		resp.Body.Close()
	}
}
