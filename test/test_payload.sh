curl -sL -H "content-type: application/json" \
  -X POST \
  --data @test_payload.json \
  https://g2fcimg3x7.execute-api.ap-southeast-2.amazonaws.com/ | jq .
