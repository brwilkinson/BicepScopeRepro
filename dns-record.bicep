param zoneName string
param dnsRecord string
param TTL int = 300
param ARecord bool = false
param TxtRecord bool = false
param dnsRecordValue string

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' existing = {
  name: zoneName
 
}

resource dnsARecord 'Microsoft.Network/dnsZones/A@2018-05-01' =  if(ARecord) { 
  name: dnsRecord
  parent: dnsZone
  properties: {
    TTL: TTL
    ARecords: [{
        ipv4Address: dnsRecordValue
      }]
  }  
}

resource dnsTxtRecord 'Microsoft.Network/dnsZones/TXT@2018-05-01' = if(TxtRecord) {
  name: dnsRecord
  parent: dnsZone
  properties: {
    TTL: TTL
    TXTRecords: [
      {
        value: [
          dnsRecordValue
        ]
      }
    ]
  }
}
