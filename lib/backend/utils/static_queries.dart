class StaticQueries {
  static const String login = '''
    mutation Login(\$email: String!) {
      login(email: \$email) {
        user {
          id
          firstName
          lastName
          email
          trips {
            trip {
              id
              title
              destination
              startDate
              endDate
              hotels {
                id
                name
                startDate
                endDate
              }
              attractions {
                id
                name
                startDate
                endDate
              }
              tripUsers {
                id
              }
            }
          }
        }
      }
    }
  ''';

  static const String createTrip = '''
    mutation CreateTrip(\$title: String!, \$destination: String!, \$startDate: DateTime!, \$endDate: DateTime!) {
      createTrip(input: {
        title: \$title
        destination: \$destination
        startDate: \$startDate
        endDate: \$endDate
      }) {
        id
        title
        destination
        startDate
        endDate
        tripUsers {
          user {
            firstName
          }
        }
      }
    }
  ''';
}
