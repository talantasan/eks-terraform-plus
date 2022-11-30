# Create a Route53 zone
aws route53 create-hosted-zone --name "${DOMAIN_NAME}." \
  --caller-reference "external-dns-test-$(date +%s)"

# Get Zone ID for the zone that was just created
ZONE_ID=$(aws route53 list-hosted-zones-by-name --output json \
  --dns-name "${DOMAIN_NAME}." --query HostedZones[0].Id --out text)

# Save a list of name servers
NAME_SERVERS=$(aws route53 list-resource-record-sets --output text \
  --hosted-zone-id $ZONE_ID --query \
  "ResourceRecordSets[?Type == 'NS'].ResourceRecords[*].Value | []" | tr '\t' '\n')

echo $NAME_SERVERS
