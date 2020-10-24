
URL="5rjspkje6b.execute-api.ap-southeast-2.amazonaws.com"

echo "\nPost to root (Must be error)"
curl -sL -H "content-type: application/json" \
  -XPOST \
  --data @test_payload.json \
  https://${URL} | jq .

echo "\nPost to trans end point"
curl -sL -H "content-type: application/json" \
  -XPOST \
  --data @tests/golang.json \
  https://${URL}/trans

echo "\nGet to root"
curl -sL -H "content-type: application/json" \
  -XGET \
  https://${URL} | jq .
