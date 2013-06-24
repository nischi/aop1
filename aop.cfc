/*
	I wrap all the functionality of the ioc bean factory and decorate it so that we can use interceptors

*/
component {

	variables.bf = ""; // our beanFactory



	function init(){
		variables.bf = new ioc(argumentCollection=arguments);

		//Also need to check if there is a "interceptors" folder, and add these as <componentName>Interceptor

		var InterceptorPath = expandPath("/interceptors");
		var Interceptors = directoryExists(InterceptorPath) ? directoryList(InterceptorPath,false,"query", "*.cfc") : [];
		dump(Interceptors);
		

		abort;
		return this;
	}

	/*
		returns the original beanFactory
	*/
	function getIOC(){
		return variables.bf;
	}

	function intercept(){
		return this;
	}

	function hasInterceptors(String BeanName){

		return false;
	}

	function onMissingMethod(methodname, args){
		//see if we have this method in the beanFactory
		if(structKeyExists(variables.bf, methodname)){
			return variables.bf[methodname](argumentCollection=args);
		}
		
		throw("Method #methodname# doesn't exist");
	}


}