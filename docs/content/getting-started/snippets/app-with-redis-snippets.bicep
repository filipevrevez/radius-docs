// Import the set of Radius resources (Applications.*) into Bicep
import radius as radius

@description('The app ID of your Radius application. Set automatically by the rad CLI.')
param application string

//CONNECTION
resource demo 'Applications.Core/containers@2022-03-15-privatepreview' = {
  name: 'demo'
  properties: {
    application: application
    container: {
      image: 'radius.azurecr.io/tutorial/webapp:edge'
      ports: {
        web: {
          containerPort: 3000
        }
      }
    }
    connections: {
      redis: {
        source: db.id
      }
    }
  }
}
//CONNECTION

//REDIS
@description('The environment ID of your Radius application. Set automatically by the rad CLI.')
param environment string

resource db 'Applications.Datastores/redisCaches@2022-03-15-privatepreview' = {
  name: 'db'
  properties: {
    application: application
    environment: environment
  }
}
//REDIS