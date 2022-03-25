function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
    //Get credential from vault
    //initilize data for testing
  } else if (env == 'e2e') {
    // customize
    //Get credential from vault
    //initilize data for testing
  } else if (env == 'preprod') {
    // customize
  } else if (env == 'prod') {
    // customize
  
  }
  return config;
}