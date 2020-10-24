curl -sL -H "content-type: application/json" \
  -X POST \
  --data @test_payload.json \
  https://apigate.dev1.littlepayco.de | jq .
