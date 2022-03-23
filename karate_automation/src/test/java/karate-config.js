function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
	shared_key: '***',
    secret_key: '***',
  }
  var configFile = 'classpath:' + env + '.json';
  try {
        config = karate.read (configFile);
        karate.configure ('connectTimeout', 60000);
        karate.configure ('readTimeout', 60000);
   } catch (e) {
          karate.log ("Failed to initialize test setup configuration - ", e);
      }
      return config;

  return config;
}
