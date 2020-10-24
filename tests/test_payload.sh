curl -sL -H "content-type: application/json" \
  -X POST \
  --data @test_payload.json \
  https://7eseyejcf0.execute-api.ap-southeast-2.amazonaws.com | jq .
