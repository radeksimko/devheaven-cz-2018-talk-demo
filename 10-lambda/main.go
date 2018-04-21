package main

import (
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(handler)
}

func handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	log.Printf("Processing Lambda request %s\n", request.RequestContext.RequestID)

	params := request.QueryStringParameters
	if _, ok := params["who"]; !ok {
		return events.APIGatewayProxyResponse{
			Body:       "No name provided",
			StatusCode: 400,
		}, nil
	}

	return events.APIGatewayProxyResponse{
		Body:       "Hi " + params["who"],
		StatusCode: 200,
	}, nil
}
