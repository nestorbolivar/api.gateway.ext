# Test lambda functions locally

# From the link below
# https://github.com/lambci/docker-lambda

# Run the lambda function locally (Python)
docker run --rm -d -e DOCKER_LAMBDA_STAY_OPEN=1 -p 9001:9001 \
  -v "$PWD/src":/var/task:ro,delegated lambci/lambda:python3.8 ext.my_handler

# Call the lambda function using aws cli (Python)
aws lambda invoke --endpoint http://localhost:9001 --no-sign-request \
  --function-name ext --payload '{}' output.json

# Call tha lambda using rest directly on using curl (Python)
curl -sL -H "content-type: application/json"\
  -X POST \
  --data @test/test_payload.json \
  http://localhost:9001/2015-03-31/functions/ext/invocations

# GOLANG:
# Get modules: go get github.com/aws/aws-lambda-go/lambda
# Compile: GOOS=linux go build main.go

# Run the lambda function locally (golang)
docker run --rm -d -e DOCKER_LAMBDA_STAY_OPEN=1 -p 9001:9001 \
  -v "$PWD/src":/var/task:ro,delegated lambci/lambda:go1.x main

# Call tha lambda using rest directly on using curl (Golang)
curl -sL -H "content-type: application/json"\
  -X POST \
  --data @test/golang.json \
  http://localhost:9002/2015-03-31/functions/main/invocations
