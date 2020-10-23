# Test lambda functions locally

# From the link below
# https://github.com/lambci/docker-lambda

# Run the lambda function locally
docker run --rm -d -e DOCKER_LAMBDA_STAY_OPEN=1 -p 9001:9001 \
  -v "$PWD/src":/var/task:ro,delegated lambci/lambda:python3.8 ext.my_handler

# Call the lambda function using aws cli
aws lambda invoke --endpoint http://localhost:9001 --no-sign-request \
  --function-name ext --payload '{}' output.json

# Call tha lambda using rest directly on using curl
curl -sL -H "content-type: application/json"\
  -X POST \
  --data @test/test_payload.json \
  http://localhost:9001/2015-03-31/functions/ext/invocations
